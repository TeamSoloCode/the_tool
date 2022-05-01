import 'package:the_tool/page_utils/context_state_provider.dart';

abstract class BaseEvalJS {
  ContextStateProvider contextStateProvider;
  BaseEvalJS({required this.contextStateProvider});

  Future<void> executeJS(String jsCode);
  void setupReactForClientCode(String clientCode);
  void unmountClientCode();
}
