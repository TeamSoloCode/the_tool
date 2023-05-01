import 'package:reflectable/reflectable.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_prop_metadata.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props_reflectable.reflectable.dart'; // Import the file containing the class you want to reflect

// Define your Reflectable class as before
class LayoutPropsReflector extends Reflectable {
  const LayoutPropsReflector()
      : super(
          declarationsCapability,
          invokingCapability,
          // subtypeQuantifyCapability,
          // typeAnnotationDeepQuantifyCapability,
          metadataCapability,
          typeCapability,
          typeRelationsCapability,
        );
}

const reflector = LayoutPropsReflector();

Map<String, bool> _ignoredComputeProps = {};
Map<String, bool> get ignoredComputeProps => _ignoredComputeProps;

void main() {
  initializeReflectable();

  TypeMirror typeMirror = reflector.reflectType(LayoutProps);
  ClassMirror classMirror = typeMirror as ClassMirror;

  LayoutPropsMetadata defaultMetadata =
      const LayoutPropsMetadata(ignoreComputeProps: false);

  classMirror.instanceMembers.forEach(
    (key, value) {
      LayoutPropsMetadata metadata = value.metadata.firstWhere(
        (annotation) => annotation is LayoutPropsMetadata,
        orElse: () => defaultMetadata,
      ) as LayoutPropsMetadata;

      if (metadata.ignoreComputeProps == true) {
        _ignoredComputeProps[key] = true;
      }
    },
  );
}
