/// One page of a cursor-paginated list, plus the key to the next one.
///
/// Cursor rather than page/offset because that is what the backend actually
/// implements on the endpoints that paginate at all: `GET /notifications`
/// answers `{data: [...], nextCursor}` and has no concept of a page number.
///
/// [nextCursor] being null is the *only* end-of-list signal. A short page is
/// not one — a filtered query can return fewer rows than the limit and still
/// have more behind it.
class CursorPage<T> {
  const CursorPage({required this.items, this.nextCursor});

  const CursorPage.empty()
      : items = const [],
        nextCursor = null;

  final List<T> items;
  final String? nextCursor;

  bool get hasMore => nextCursor != null;

  /// Appends the next page, preserving order. Used by controllers that keep one
  /// growing list in state rather than a list of pages.
  CursorPage<T> append(CursorPage<T> next) => CursorPage<T>(
        items: [...items, ...next.items],
        nextCursor: next.nextCursor,
      );
}
