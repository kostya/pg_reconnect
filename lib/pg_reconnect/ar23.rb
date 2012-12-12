class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter

  MAX_QUERY_RETRIES = 1

  alias_method :execute_without_retry, :execute
  alias_method :query_without_retry, :query

  def query(*args)
    res = query_without_retry(*args)
    @retry_counter = nil
    res
  rescue ActiveRecord::StatementInvalid => ex
    unless active?
      @retry_counter ||= 0
      @logger.warn "Reconnecting to database after PGError! Try ##{@retry_counter + 1}/#{MAX_QUERY_RETRIES} #{ex.message}, trace: #{ex.backtrace.inspect}"
      reconnect! rescue nil

      if @retry_counter < MAX_QUERY_RETRIES
        @retry_counter += 1
        retry
      end
    end
    
    raise
  end

  def execute(*args)
    res = execute_without_retry(*args)
    @retry_counter = nil
    res
  rescue ActiveRecord::StatementInvalid => ex
    unless active?
      @retry_counter ||= 0
      @logger.warn "Reconnecting to database after PGError! Try ##{@retry_counter + 1}/#{MAX_QUERY_RETRIES} #{ex.message}, trace: #{ex.backtrace.inspect}"
      reconnect! rescue nil

      if @retry_counter < MAX_QUERY_RETRIES
        @retry_counter += 1
        retry
      end
    end
    
    raise
  end

end