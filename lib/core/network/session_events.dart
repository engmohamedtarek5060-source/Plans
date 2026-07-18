import 'dart:async';

/// Broadcasts "the session died" from the network layer to whoever owns auth
/// state.
///
/// The interceptor that observes a 401 lives below the presentation layer and
/// must not reach up into it; this one-way channel keeps that boundary intact.
class SessionEvents {
  SessionEvents();

  final _controller = StreamController<void>.broadcast();

  /// Emits whenever the backend rejects our token (401).
  Stream<void> get onUnauthorized => _controller.stream;

  bool _signalling = false;

  /// Signals a forced logout. Re-entrant calls are ignored, so a burst of
  /// parallel 401s (e.g. five screens refreshing at once) logs out only once.
  void signalUnauthorized() {
    if (_signalling || _controller.isClosed) return;
    _signalling = true;
    _controller.add(null);
    // Collapse only the synchronous burst; a later, genuine 401 still fires.
    scheduleMicrotask(() => _signalling = false);
  }

  void dispose() => _controller.close();
}
