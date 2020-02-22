import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:built_graphql/src/schema/definitions/definitions.dart'
    show
        Variable,
        GraphQLEntity,
        Argument,
        Directive,
        NamedType,
        GraphQLType,
        DefaultValue;

part 'selections.dart';

@immutable
abstract class ExecutableGraphQLEntity extends GraphQLEntity {
  const ExecutableGraphQLEntity();
}

@immutable
abstract class ExecutableDefinition extends ExecutableGraphQLEntity {
  const ExecutableDefinition();

  @override
  ExecutableDefinitionNode get astNode;

  static ExecutableDefinition fromNode(ExecutableDefinitionNode astNode) {
    if (astNode is OperationDefinitionNode) {
      return OperationDefinition.fromNode(astNode);
    }
    if (astNode is FragmentDefinitionNode) {
      return FragmentDefinition.fromNode(astNode);
    }

    throw ArgumentError('$astNode is unsupported');
  }
}

@immutable
class OperationDefinition extends ExecutableDefinition {
  const OperationDefinition(this.astNode);

  @override
  final OperationDefinitionNode astNode;

  OperationType get type => astNode.type;

  List<VariableDefinition> get variables =>
      astNode.variableDefinitions.map(VariableDefinition.fromNode).toList();

  SelectionSet get selectionSet => SelectionSet.fromNode(astNode.selectionSet);

  static OperationDefinition fromNode(OperationDefinitionNode astNode) =>
      OperationDefinition(astNode);
}

@immutable
class FragmentDefinition extends ExecutableDefinition {
  const FragmentDefinition(this.astNode);

  @override
  final FragmentDefinitionNode astNode;

  TypeCondition get typeCondition =>
      TypeCondition.fromNode(astNode.typeCondition);

  List<Directive> get directives =>
      astNode.directives.map(Directive.fromNode).toList();
  SelectionSet get selectionSet => SelectionSet.fromNode(astNode.selectionSet);

  static FragmentDefinition fromNode(FragmentDefinitionNode astNode) =>
      FragmentDefinition(astNode);
}

@immutable
class TypeCondition extends ExecutableGraphQLEntity {
  const TypeCondition(this.astNode);

  @override
  final TypeConditionNode astNode;

  NamedType get on => NamedType.fromNode(astNode.on);

  static TypeCondition fromNode(TypeConditionNode astNode) =>
      TypeCondition(astNode);
}

@immutable
class VariableDefinition extends ExecutableGraphQLEntity {
  const VariableDefinition(this.astNode);

  @override
  final VariableDefinitionNode astNode;

  Variable get variable => Variable.fromNode(astNode.variable);

  GraphQLType get type => GraphQLType.fromNode(astNode.type);

  DefaultValue get defaultValue => DefaultValue.fromNode(astNode.defaultValue);

  List<Directive> get directives =>
      astNode.directives.map(Directive.fromNode).toList();

  static VariableDefinition fromNode(VariableDefinitionNode astNode) =>
      VariableDefinition(astNode);
}