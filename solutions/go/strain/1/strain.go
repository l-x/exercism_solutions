package strain

func negate[T any](predicate func(T) bool) func(T) bool {
	return func(item T) bool {
		return !predicate(item)
	}
}

func Keep[T any](collection []T, predicate func(T) bool) (result []T) {
	for _, item := range collection {
		if predicate(item) {
			result = append(result, item)
		}
	}
	return
}

func Discard[T any](collection []T, predicate func(T) bool) (result []T) {
	return Keep(
		collection,
		negate(predicate),
	)
}
