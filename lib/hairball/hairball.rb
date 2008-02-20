module Hairball
  include Treetop::Runtime

  def root
    @root || :source
  end

  module Source0
    def space
      elements[0]
    end

    def element
      elements[1]
    end
  end

  module Source1
    def source
      "_src='';" + element.source + "_src;"
    end
  end

  def _nt_source
    start_index = index
    if node_cache[:source].has_key?(index)
      cached = node_cache[:source][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      r2 = _nt_element
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Source0)
      r0.extend(Source1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:source][start_index] = r0

    return r0
  end

  module Element0
    def div_element
      elements[0]
    end

    def space
      elements[2]
    end

    def element
      elements[3]
    end

    def space
      elements[4]
    end

    def sibling
      elements[6]
    end
  end

  module Element1
    def source
      div_element.open_source + element.source + div_element.close_source + sibling.source
    end
  end

  module Element2
    def standard_element
      elements[0]
    end

    def space
      elements[2]
    end

    def element
      elements[3]
    end

    def space
      elements[4]
    end

    def sibling
      elements[6]
    end
  end

  module Element3
    def source
      standard_element.open_source + element.source + standard_element.close_source + sibling.source
    end
  end

  module Element4
    def space
      elements[0]
    end

    def string
      elements[1]
    end

    def space
      elements[2]
    end
  end

  module Element5
    def source
      "_src.concat('" + string.source + "');"
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
        r4 = _nt_space
        s1 << r4
        if r4
          r5 = _nt_element
          s1 << r5
          if r5
            r6 = _nt_space
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
          r12 = _nt_space
          s9 << r12
          if r12
            r13 = _nt_element
            s9 << r13
            if r13
              r14 = _nt_space
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
        i17, s17 = index, []
        r18 = _nt_space
        s17 << r18
        if r18
          r19 = _nt_string
          s17 << r19
          if r19
            r20 = _nt_space
            s17 << r20
          end
        end
        if s17.last
          r17 = (SyntaxNode).new(input, i17...index, s17)
          r17.extend(Element4)
          r17.extend(Element5)
        else
          self.index = i17
          r17 = nil
        end
        if r17
          r0 = r17
        else
          r21 = _nt_ruby
          if r21
            r0 = r21
          else
            r22 = _nt_space
            if r22
              r0 = r22
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

  module StandardElement0
    def space
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
    def open_source
      "_src.concat('<" + element_name.source + attributes.source + ">');"
    end
    # @html[hello:"world"]
    # => _src.concat('<html hello="world">');
    
    def close_source
      "_src.concat('</" + element_name.source + ">');"
    end
    # _src.concat('</html>');
  end

  def _nt_standard_element
    start_index = index
    if node_cache[:standard_element].has_key?(index)
      cached = node_cache[:standard_element][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
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
    def space
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
    def open_source
      "_src.concat('<div " + div_type.source + attributes.source + ">');"
    end
    # .hello[world:"ok"]
    # => _src.concat('<div class="hello" world="ok">');
    
    def close_source
      "_src.concat('</div>');"
    end
    # _src.concat('</div>');
  end

  def _nt_div_element
    start_index = index
    if node_cache[:div_element].has_key?(index)
      cached = node_cache[:div_element][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
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
    def source
      "class=\"" + element_name.source + "\""
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
    def source
      "id=\"" + element_name.source + "\""
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
    def space
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
    r1 = _nt_space
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
    def space
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
    r1 = _nt_space
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
    def space
      elements[1]
    end

    def attribute_pair
      elements[2]
    end
  end

  module Attributes1
    def space
      elements[1]
    end

    def attribute_pair
      elements[2]
    end

    def more_attribute_pairs
      elements[3]
    end

    def space
      elements[4]
    end

    def space
      elements[6]
    end
  end

  module Attributes2
    def source
    	attribute_pairs.inject("") do |h, pair| 
    	  h += pair.source 
    	end
	    end
	    # [class:"hello";id:"world"] 
	    # => class='hello' id='world'
	
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
      r3 = _nt_space
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
              r8 = _nt_space
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
            r10 = _nt_space
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
                r12 = _nt_space
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
      r13 = _nt_space
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
    def source
      ' ' + element_name.source + '="' + string.source + '"'
    end
    # class:"content" => class='content'
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
    def source
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
    	def source
    		%{#{text_value.gsub('"', '')}}
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

  module MandatorySpace0
    def source
      ' '
    end
  end

  def _nt_mandatory_space
    start_index = index
    if node_cache[:mandatory_space].has_key?(index)
      cached = node_cache[:mandatory_space][index]
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
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = SyntaxNode.new(input, i0...index, s0)
      r0.extend(MandatorySpace0)
    end

    node_cache[:mandatory_space][start_index] = r0

    return r0
  end

  module Space0
    def source
      ''
    end
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
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
    r0.extend(Space0)

    node_cache[:space][start_index] = r0

    return r0
  end

  def _nt_ruby
    start_index = index
    if node_cache[:ruby].has_key?(index)
      cached = node_cache[:ruby][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_block
    if r1
      r0 = r1
    else
      r2 = _nt_single_line_output
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:ruby][start_index] = r0

    return r0
  end

  module SingleLineOutput0
  end

  module SingleLineOutput1
  end

  module SingleLineOutput2
    def source
      "_src.concat((" + code + ").to_s);"
    end
    
    def code
      text_value.gsub(/^<%/, "").gsub(/%>$/, "")
    end
  end

  def _nt_single_line_output
    start_index = index
    if node_cache[:single_line_output].has_key?(index)
      cached = node_cache[:single_line_output][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    r2 = _nt_ruby_start_block
    if r2
      r1 = nil
    else
      self.index = i1
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      i3 = index
      r4 = _nt_ruby_end_block
      if r4
        r3 = nil
      else
        self.index = i3
        r3 = SyntaxNode.new(input, index...index)
      end
      s0 << r3
      if r3
        if input.index('<%', index) == index
          r5 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure('<%')
          r5 = nil
        end
        s0 << r5
        if r5
          s6, i6 = [], index
          loop do
            i7, s7 = index, []
            i8 = index
            if input.index('%>', index) == index
              r9 = (SyntaxNode).new(input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure('%>')
              r9 = nil
            end
            if r9
              r8 = nil
            else
              self.index = i8
              r8 = SyntaxNode.new(input, index...index)
            end
            s7 << r8
            if r8
              if index < input_length
                r10 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("any character")
                r10 = nil
              end
              s7 << r10
            end
            if s7.last
              r7 = (SyntaxNode).new(input, i7...index, s7)
              r7.extend(SingleLineOutput0)
            else
              self.index = i7
              r7 = nil
            end
            if r7
              s6 << r7
            else
              break
            end
          end
          r6 = SyntaxNode.new(input, i6...index, s6)
          s0 << r6
          if r6
            if input.index('%>', index) == index
              r11 = (SyntaxNode).new(input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure('%>')
              r11 = nil
            end
            s0 << r11
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SingleLineOutput1)
      r0.extend(SingleLineOutput2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:single_line_output][start_index] = r0

    return r0
  end

  module Block0
    def ruby_start_block
      elements[0]
    end

    def space
      elements[1]
    end

    def element
      elements[2]
    end

    def space
      elements[3]
    end

    def ruby_end_block
      elements[4]
    end

    def space
      elements[5]
    end
  end

  module Block1
    def source
      ruby_start_block.source +  element.source + ruby_end_block.source
    end
  end

  def _nt_block
    start_index = index
    if node_cache[:block].has_key?(index)
      cached = node_cache[:block][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_ruby_start_block
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_element
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            r5 = _nt_ruby_end_block
            s0 << r5
            if r5
              r6 = _nt_space
              s0 << r6
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Block0)
      r0.extend(Block1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:block][start_index] = r0

    return r0
  end

  module RubyStartBlock0
  end

  module RubyStartBlock1
    def space
      elements[0]
    end

    def mandatory_space
      elements[3]
    end

    def space
      elements[6]
    end

  end

  module RubyStartBlock2
    def source
      text_value.gsub(/<%/, "").gsub(/%>/, "").strip + ";"
    end
  end

  def _nt_ruby_start_block
    start_index = index
    if node_cache[:ruby_start_block].has_key?(index)
      cached = node_cache[:ruby_start_block][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if input.index('<%', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure('<%')
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          i4, s4 = index, []
          i5 = index
          if input.index(' do', index) == index
            r6 = (SyntaxNode).new(input, index...(index + 3))
            @index += 3
          else
            terminal_parse_failure(' do')
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
            r4.extend(RubyStartBlock0)
          else
            self.index = i4
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = SyntaxNode.new(input, i3...index, s3)
        s0 << r3
        if r3
          r8 = _nt_mandatory_space
          s0 << r8
          if r8
            if input.index('do', index) == index
              r9 = (SyntaxNode).new(input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure('do')
              r9 = nil
            end
            s0 << r9
            if r9
              r11 = _nt_argument_list
              if r11
                r10 = r11
              else
                r10 = SyntaxNode.new(input, index...index)
              end
              s0 << r10
              if r10
                r12 = _nt_space
                s0 << r12
                if r12
                  if input.index('%>', index) == index
                    r13 = (SyntaxNode).new(input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure('%>')
                    r13 = nil
                  end
                  s0 << r13
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(RubyStartBlock1)
      r0.extend(RubyStartBlock2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:ruby_start_block][start_index] = r0

    return r0
  end

  module RubyEndBlock0
    def space
      elements[1]
    end

    def space
      elements[3]
    end

  end

  module RubyEndBlock1
    def source
      'end;'
    end
  end

  def _nt_ruby_end_block
    start_index = index
    if node_cache[:ruby_end_block].has_key?(index)
      cached = node_cache[:ruby_end_block][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('<%', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure('<%')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        if input.index('end', index) == index
          r3 = (SyntaxNode).new(input, index...(index + 3))
          @index += 3
        else
          terminal_parse_failure('end')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index('%>', index) == index
              r5 = (SyntaxNode).new(input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure('%>')
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(RubyEndBlock0)
      r0.extend(RubyEndBlock1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:ruby_end_block][start_index] = r0

    return r0
  end

  module ArgumentList0
    def mandatory_space
      elements[0]
    end

    def parameter_without_comma
      elements[3]
    end

    def space
      elements[5]
    end
  end

  def _nt_argument_list
    start_index = index
    if node_cache[:argument_list].has_key?(index)
      cached = node_cache[:argument_list][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_mandatory_space
    s0 << r1
    if r1
      if input.index('|', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('|')
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          r4 = _nt_parameter_with_comma
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = SyntaxNode.new(input, i3...index, s3)
        s0 << r3
        if r3
          r5 = _nt_parameter_without_comma
          s0 << r5
          if r5
            if input.index('|', index) == index
              r6 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure('|')
              r6 = nil
            end
            s0 << r6
            if r6
              r7 = _nt_space
              s0 << r7
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(ArgumentList0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:argument_list][start_index] = r0

    return r0
  end

  module ParameterWithComma0
    def space
      elements[0]
    end

    def element_name
      elements[1]
    end

    def space
      elements[2]
    end

    def space
      elements[4]
    end
  end

  def _nt_parameter_with_comma
    start_index = index
    if node_cache[:parameter_with_comma].has_key?(index)
      cached = node_cache[:parameter_with_comma][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      r2 = _nt_element_name
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
        if r3
          if input.index(',', index) == index
            r4 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(',')
            r4 = nil
          end
          s0 << r4
          if r4
            r5 = _nt_space
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(ParameterWithComma0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:parameter_with_comma][start_index] = r0

    return r0
  end

  module ParameterWithoutComma0
    def space
      elements[0]
    end

    def element_name
      elements[1]
    end

    def space
      elements[2]
    end
  end

  def _nt_parameter_without_comma
    start_index = index
    if node_cache[:parameter_without_comma].has_key?(index)
      cached = node_cache[:parameter_without_comma][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      r2 = _nt_element_name
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(ParameterWithoutComma0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:parameter_without_comma][start_index] = r0

    return r0
  end

end

class HairballParser < Treetop::Runtime::CompiledParser
  include Hairball
end
