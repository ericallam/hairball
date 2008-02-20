module HTML3000
  include Treetop::Runtime

  def root
    @root || :element
  end

  module Element0
    def div_element
      elements[0]
    end

    def whitespace
      elements[2]
    end

    def element
      elements[3]
    end

    def whitespace
      elements[4]
    end

    def sibling
      elements[6]
    end
  end

  module Element1
    def value(env)
      div_element.open_value(env) + element.value(env) + div_element.close_value(env) + sibling.value(env)
    end
  end

  module Element2
    def standard_element
      elements[0]
    end

    def whitespace
      elements[2]
    end

    def element
      elements[3]
    end

    def whitespace
      elements[4]
    end

    def sibling
      elements[6]
    end
  end

  module Element3
    def value(env)
      standard_element.open_value(env) + element.value(env) + standard_element.close_value(env) + sibling.value(env)
    end
  end

  def _nt_element
    start_index = index
    if node_cache[:element].has_key?(index)
      cached = node_cache[:element][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_div_element
    s1 << r2
    if r2
      if input.index('{', index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('{')
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_whitespace
        s1 << r4
        if r4
          r5 = _nt_element
          s1 << r5
          if r5
            r6 = _nt_whitespace
            s1 << r6
            if r6
              if input.index('}', index) == index
                r7 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('}')
                r7 = nil
              end
              s1 << r7
              if r7
                r8 = _nt_element
                s1 << r8
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Element0)
      r1.extend(Element1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_standard_element
      s9 << r10
      if r10
        if input.index('{', index) == index
          r11 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('{')
          r11 = nil
        end
        s9 << r11
        if r11
          r12 = _nt_whitespace
          s9 << r12
          if r12
            r13 = _nt_element
            s9 << r13
            if r13
              r14 = _nt_whitespace
              s9 << r14
              if r14
                if input.index('}', index) == index
                  r15 = (SyntaxNode).new(input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure('}')
                  r15 = nil
                end
                s9 << r15
                if r15
                  r16 = _nt_element
                  s9 << r16
                end
              end
            end
          end
        end
      end
      if s9.last
        r9 = (SyntaxNode).new(input, i9...index, s9)
        r9.extend(Element2)
        r9.extend(Element3)
      else
        self.index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        r17 = _nt_string
        if r17
          r0 = r17
        else
          r18 = _nt_ruby
          if r18
            r0 = r18
          else
            r19 = _nt_whitespace
            if r19
              r0 = r19
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:element][start_index] = r0

    return r0
  end

  module Ruby0
  end

  module Ruby1
  end

  module Ruby2
    def value(env)
      eval(code, env).to_s
    end
    
    def code
      text_value.gsub(/^%/, "").gsub(/%$/, "")
    end
  end

  def _nt_ruby
    start_index = index
    if node_cache[:ruby].has_key?(index)
      cached = node_cache[:ruby][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('%', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('%')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        i4 = index
        if input.index('%', index) == index
          r5 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('%')
          r5 = nil
        end
        if r5
          r4 = nil
        else
          self.index = i4
          r4 = SyntaxNode.new(input, index...index)
        end
        s3 << r4
        if r4
          if index < input_length
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r6 = nil
          end
          s3 << r6
        end
        if s3.last
          r3 = (SyntaxNode).new(input, i3...index, s3)
          r3.extend(Ruby0)
        else
          self.index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('%', index) == index
          r7 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('%')
          r7 = nil
        end
        s0 << r7
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Ruby1)
      r0.extend(Ruby2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:ruby][start_index] = r0

    return r0
  end

  module StandardElement0
    def whitespace
      elements[0]
    end

    def standard_element_token
      elements[1]
    end

    def element_name
      elements[2]
    end

    def attributes
      elements[3]
    end
  end

  module StandardElement1
    def open_value(env)
      "<" + element_name.value(env) + attributes.value(env) + ">"
    end
    
    def close_value(env)
      "</" + element_name.value(env) + ">"
    end
  end

  def _nt_standard_element
    start_index = index
    if node_cache[:standard_element].has_key?(index)
      cached = node_cache[:standard_element][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_whitespace
    s0 << r1
    if r1
      r2 = _nt_standard_element_token
      s0 << r2
      if r2
        r3 = _nt_element_name
        s0 << r3
        if r3
          r4 = _nt_attributes
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(StandardElement0)
      r0.extend(StandardElement1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:standard_element][start_index] = r0

    return r0
  end

  def _nt_standard_element_token
    start_index = index
    if node_cache[:standard_element_token].has_key?(index)
      cached = node_cache[:standard_element_token][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index("@", index) == index
      r0 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("@")
      r0 = nil
    end

    node_cache[:standard_element_token][start_index] = r0

    return r0
  end

  module DivElement0
    def whitespace
      elements[0]
    end

    def div_type
      elements[1]
    end

    def attributes
      elements[2]
    end
  end

  module DivElement1
    def open_value(env)
      "<div " + div_type.value(env) + attributes.value(env) + ">"
    end
    
    def close_value(env)
      "</div>"
    end
  end

  def _nt_div_element
    start_index = index
    if node_cache[:div_element].has_key?(index)
      cached = node_cache[:div_element][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_whitespace
    s0 << r1
    if r1
      r2 = _nt_div_type
      s0 << r2
      if r2
        r3 = _nt_attributes
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(DivElement0)
      r0.extend(DivElement1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:div_element][start_index] = r0

    return r0
  end

  module DivType0
    def class
      elements[0]
    end

    def element_name
      elements[1]
    end
  end

  module DivType1
    def value(env)
      "class='#{element_name.value(env)}'"
    end
  end

  module DivType2
    def id
      elements[0]
    end

    def element_name
      elements[1]
    end
  end

  module DivType3
    def value(env)
      "id='#{element_name.value(env)}'"
    end
  end

  def _nt_div_type
    start_index = index
    if node_cache[:div_type].has_key?(index)
      cached = node_cache[:div_type][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_class
    s1 << r2
    if r2
      r3 = _nt_element_name
      s1 << r3
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(DivType0)
      r1.extend(DivType1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i4, s4 = index, []
      r5 = _nt_id
      s4 << r5
      if r5
        r6 = _nt_element_name
        s4 << r6
      end
      if s4.last
        r4 = (SyntaxNode).new(input, i4...index, s4)
        r4.extend(DivType2)
        r4.extend(DivType3)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:div_type][start_index] = r0

    return r0
  end

  module Class0
    def whitespace
      elements[0]
    end

  end

  def _nt_class
    start_index = index
    if node_cache[:class].has_key?(index)
      cached = node_cache[:class][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_whitespace
    s0 << r1
    if r1
      if input.index('.', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('.')
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Class0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:class][start_index] = r0

    return r0
  end

  module Id0
    def whitespace
      elements[0]
    end

  end

  def _nt_id
    start_index = index
    if node_cache[:id].has_key?(index)
      cached = node_cache[:id][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_whitespace
    s0 << r1
    if r1
      if input.index('#', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('#')
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Id0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:id][start_index] = r0

    return r0
  end

  module Attributes0
    def whitespace
      elements[1]
    end

    def attribute_pair
      elements[2]
    end
  end

  module Attributes1
    def whitespace
      elements[1]
    end

    def attribute_pair
      elements[2]
    end

    def more_attribute_pairs
      elements[3]
    end

    def whitespace
      elements[4]
    end

    def whitespace
      elements[6]
    end
  end

  module Attributes2
    def value(env)
    	attribute_pairs.inject('') {|h, pair| h += pair.value(env) }
	    end
	
	  def attribute_pairs
		  [attribute_pair] + more_attribute_pairs.elements.map {|elt| elt.attribute_pair }
	  end
  end

  def _nt_attributes
    start_index = index
    if node_cache[:attributes].has_key?(index)
      cached = node_cache[:attributes][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index('[', index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('[')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_whitespace
      s1 << r3
      if r3
        r4 = _nt_attribute_pair
        s1 << r4
        if r4
          s5, i5 = [], index
          loop do
            i6, s6 = index, []
            if input.index(';', index) == index
              r7 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(';')
              r7 = nil
            end
            s6 << r7
            if r7
              r8 = _nt_whitespace
              s6 << r8
              if r8
                r9 = _nt_attribute_pair
                s6 << r9
              end
            end
            if s6.last
              r6 = (SyntaxNode).new(input, i6...index, s6)
              r6.extend(Attributes0)
            else
              self.index = i6
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = SyntaxNode.new(input, i5...index, s5)
          s1 << r5
          if r5
            r10 = _nt_whitespace
            s1 << r10
            if r10
              if input.index(']', index) == index
                r11 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(']')
                r11 = nil
              end
              s1 << r11
              if r11
                r12 = _nt_whitespace
                s1 << r12
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Attributes1)
      r1.extend(Attributes2)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r13 = _nt_whitespace
      if r13
        r0 = r13
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:attributes][start_index] = r0

    return r0
  end

  module AttributePair0
    def element_name
      elements[0]
    end

    def string
      elements[2]
    end
  end

  module AttributePair1
    def value(env)
      " " + element_name.value(env) + "='" + string.value(env) + "'"
    end
  end

  def _nt_attribute_pair
    start_index = index
    if node_cache[:attribute_pair].has_key?(index)
      cached = node_cache[:attribute_pair][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_element_name
    s0 << r1
    if r1
      if input.index(':', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(':')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_string
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(AttributePair0)
      r0.extend(AttributePair1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:attribute_pair][start_index] = r0

    return r0
  end

  module ElementName0
  end

  module ElementName1
    def value(env)
      text_value.to_s
    end
  end

  def _nt_element_name
    start_index = index
    if node_cache[:element_name].has_key?(index)
      cached = node_cache[:element_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    s1, i1 = [], index
    loop do
      if input.index(/[a-zA-Z]/, index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      if r2
        s1 << r2
      else
        break
      end
    end
    if s1.empty?
      self.index = i1
      r1 = nil
    else
      r1 = SyntaxNode.new(input, i1...index, s1)
    end
    s0 << r1
    if r1
      if input.index(/[1-6]/, index) == index
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r4 = nil
      end
      if r4
        r3 = r4
      else
        r3 = SyntaxNode.new(input, index...index)
      end
      s0 << r3
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(ElementName0)
      r0.extend(ElementName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:element_name][start_index] = r0

    return r0
  end

  module String0
  end

  module String1
  end

  module String2
    	def value(env)
    		text_value.to_s.gsub('"', "").to_s
    	end
  end

  def _nt_string
    start_index = index
    if node_cache[:string].has_key?(index)
      cached = node_cache[:string][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('"', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index('"', index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(String0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index('\"', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\"')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('"', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(String1)
      r0.extend(String2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:string][start_index] = r0

    return r0
  end

  module Whitespace0
    def value(env)
      ''
    end
  end

  def _nt_whitespace
    start_index = index
    if node_cache[:whitespace].has_key?(index)
      cached = node_cache[:whitespace][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(/[\s]/, index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)
    r0.extend(Whitespace0)

    node_cache[:whitespace][start_index] = r0

    return r0
  end

end

class HTML3000Parser < Treetop::Runtime::CompiledParser
  include HTML3000
end
