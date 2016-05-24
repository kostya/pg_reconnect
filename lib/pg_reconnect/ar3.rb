class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter

  MAX_QUERY_RETRIES = 1

  alias_method :exec_query_without_retry, :exec_query
  
  def exec_query(*args)
    res = exec_query_without_retry(*args)
    @retry_counter = nil
    res
  rescue ActiveRecord::StatementInvalid => ex
    unless active?        
      @retry_counter ||= 0
      send(:log, Logger::WARN) { "Reconnecting to database after PGError! Try ##{@retry_counter + 1}/#{MAX_QUERY_RETRIES} #{ex.message}, trace: #{ex.backtrace.inspect}" }

      if @retry_counter < MAX_QUERY_RETRIES
        @retry_counter += 1
        reconnect! rescue nil
        retry if active?
      end
    end
    
    @retry_counter = 0
    raise
  end

end
