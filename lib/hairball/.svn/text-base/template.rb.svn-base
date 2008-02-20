module HTML3000
  class Template3000
    include HTML3000

    def initialize(path, env={})
      @template = read_file(path)
      set_instance_variables(env)
    end

    def to_html
      parser.parse(@template).value(binding)
    end

    private

    def parser
      @parser ||= HTML3000Parser.new
    end

    def set_instance_variables(vars)
      vars.each do |key, value|
        instance_variable_set "@#{key.to_s}", value
      end
    end

    def read_file(path)
      File.read(File.join(root_path, "#{path.to_s}.3000")).chomp
    end

    def root_path
      TEMPLATE_ROOT
    end
  end
end