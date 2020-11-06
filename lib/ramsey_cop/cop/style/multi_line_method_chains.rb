module RamseyCop
  module Cop
    module Style
      class MultiLineMethodChains < RuboCop::Cop::Cop
        MSG = "Break out each method in a chain onto its own line".freeze

        def on_send(node)
          return unless poorly_formatted_method_chain?(node)

          add_offense(node, severity: :warning)
        end

        alias_method :on_csend, :on_send

        def next_node_is_send?(node)
          %i(send csend).include?(node.children.first&.type)
        end

        def method_chain(node)
          current_node = node

          [node].tap do |links|
            while next_node_is_send?(current_node)
              current_node = current_node.children.first
              links << current_node
            end
          end
        end

        def poorly_formatted_method_chain?(node)
          return unless next_node_is_send?(node)

          expression_length = expression_length(node)
          return if expression_length == 1

          method_chain(node).length > expression_length
        end

        def expression_length(node)
          (node.loc.last_line - node.loc.line) + 1
        end
      end
    end
  end
end
