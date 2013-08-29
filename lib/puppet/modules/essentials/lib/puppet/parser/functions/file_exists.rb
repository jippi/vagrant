module Puppet::Parser::Functions

  newfunction(:file_exists, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Check if a file exists
    ENDHEREDOC

    unless args.length == 1
      raise Puppet::ParseError, ("file_exists(): wrong number of arguments (#{args.length}; must be 1)")
    end

    File.exists?(args[0])

  end

end
