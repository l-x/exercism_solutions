package linkedlist

import "errors"

type Node struct {
	Value any
	prev  *Node
	next  *Node
}

func (n *Node) flip() {
	if n == nil {
		return
	}

	n.next, n.prev = n.prev, n.next

	if n.prev != nil {
		n.prev.flip()
	}
}

type List struct {
	first,
	last *Node
}

func (l *List) is_empty() bool {
	return l.first == nil || l.last == nil
}

func NewList(elements ...any) *List {
	l := &List{}

	for _, el := range elements {
		l.Push(el)
	}

	return l
}

func (n *Node) Next() *Node {
	return n.next
}

func (n *Node) Prev() *Node {
	return n.prev
}

func (l *List) Unshift(v any) {
	item := &Node{Value: v, next: l.first}

	if l.is_empty() {
		l.last = item
		l.first = item
	} else {
		l.first.prev = item
		l.first = item
	}

}

func (l *List) Push(v any) {
	item := &Node{Value: v, prev: l.last}

	if l.is_empty() {
		l.last = item
		l.first = item
	} else {
		l.last.next = item
		l.last = item
	}

}

func (l *List) Shift() (any, error) {
	if l.is_empty() {
		return nil, errors.New("empty list")
	}

	value := l.first.Value

	if l.first == l.last {
		l.first = nil
		l.last = nil
	} else {
		l.first.next.prev = nil
		l.first = l.first.next
	}

	return value, nil
}

func (l *List) Pop() (any, error) {
	if l.is_empty() {
		return nil, errors.New("empty list")
	}

	value := l.last.Value

	if l.first == l.last {
		l.first = nil
		l.last = nil
	} else {
		l.last.prev.next = nil
		l.last = l.last.prev
	}

	return value, nil
}

func (l *List) Reverse() {
	l.first.flip()
	l.first, l.last = l.last, l.first
}

func (l *List) First() *Node {
	return l.first
}

func (l *List) Last() *Node {
	return l.last
}
