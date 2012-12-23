# PgReconnect

ActiveRecord PostgreSQL auto-reconnection, works with 2.3 and 3.2 rails.
Uses hackety wrapper on adapter execute.
Ideal for using with pgbouncer and large number of almost idle connections (in threads).

## Installation

Add this line to your application's Gemfile:

    gem 'pg_reconnect'

