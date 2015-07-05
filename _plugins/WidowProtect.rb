module WidowProtect
    def windowprotect(input)
        bits = input.rpartition(' ')
        bits.first + '&nbsp;' + bits.last
    end
end

Liquid::Template.register_filter(WidowProtect)