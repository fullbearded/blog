# rails 切换数据库链接
## 环境
 ruby 2.0
 rails 4
 activerecord 4.0
## 前沿
最近有个项目，需要在同一个rails项目中使用不同的数据库，看了一下rails源码，发现实现是这样的


####lib/active_record/connection_handling.rb
<pre>
   # Establishes the connection to the database. Accepts a hash as input where
    # the <tt>:adapter</tt> key must be specified with the name of a database adapter (in lower-case)
    # example for regular databases (MySQL, Postgresql, etc):
    #
    #   ActiveRecord::Base.establish_connection(
    #     adapter:  "mysql",
    #     host:     "localhost",
    #     username: "myuser",
    #     password: "mypass",
    #     database: "somedatabase"
    #   )
    #
    # Example for SQLite database:
    #
    #   ActiveRecord::Base.establish_connection(
    #     adapter:  "sqlite",
    #     database: "path/to/dbfile"
    #   )
    #
    # Also accepts keys as strings (for parsing from YAML for example):
    #
    #   ActiveRecord::Base.establish_connection(
    #     "adapter"  => "sqlite",
    #     "database" => "path/to/dbfile"
    #   )
    #
    # Or a URL:
    #
    #   ActiveRecord::Base.establish_connection(
    #     "postgres://myuser:mypass@localhost/somedatabase"
    #   )
    #
    # The exceptions AdapterNotSpecified, AdapterNotFound and ArgumentError
    def establish_connection(spec = ENV["DATABASE_URL"])
      resolver = ConnectionAdapters::ConnectionSpecification::Resolver.new spec, configurations
      spec = resolver.spec

      unless respond_to?(spec.adapter_method)
        raise AdapterNotFound, "database configuration specifies nonexistent #{spec.config[:adapter]} adapter"
      end

      remove_connection
      connection_handler.establish_connection self, spec
    end
</pre>



我们可以在我们项目使用：来切换数据库

<pre>
class User < ActiveRecord::Base
  include ::W58share::DbConnection
end

module w58share
  module DbConnection
  	def self.included(base)
  	  database = YAML.load_file File.join(Rails.root.join('config', 'database.yml')).to_s
  	  base.establish_connection(database['w58share'][Rails.env])
  	  
  	  # 或者手动写
  	  # base.class_eval do
      #   @@w58share_db_spec ||= ::ActiveRecord::ConnectionAdapters::ConnectionSpecification::Resolver.new(
      #     YAML.load_file(
      #       File.join(Rails.root.join('config', 'database.yml').to_s)['w58share'][Rails.env], configurations
      #     )
      #   ).spec
      #   remove_connection
      #   connection_handler.establish_connection(name, @@w58share_db_spec)
      # end
  	end
  end
end

</pre>
