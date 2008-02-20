module Hairball
  class Template3000
    include Hairball

    def initialize(path, env={})
      @template = read_file(path)
      set_instance_variables(env)
    end

    def to_html
      eval(src, binding)
    end
    
    def src
      parser.parse(@template).source
    end

    private

    def parser
      @parser ||= HairballParser.new
    end

    def set_instance_variables(vars)
      vars.each do |key, value|
        instance_variable_set "@#{key.to_s}", value
      end
    end

    def read_file(path)
      File.read(File.join(root_path, "#{path.to_s}.habl")).chomp
    end

    def root_path
      TEMPLATE_ROOT
    end
  end
end