---
title: Map类方法整理（jdk8）
tags: [java]
categories: [java]
date: 2024-02-19 11:09:55
---

# 前言

今天在查看力扣周赛385题解时，发现了几个我平时没注意的map方法，看了jdk相关的源码，感觉很巧妙，可以帮我节省代码，于是乎顺带着整个Map类的方法都过了一遍，下面是我看后整理的内容。

Map类中包括了以下方法：

- [clear()](#clear)

- [compute(K,BiFunction<K,V,V>)](#computekbifunctionkvv)

- [computeIfAbsent(K,Function<K,V>)](#computeifabsentkfunctionkv)

- [computeIfPresent(K,BiFunction<K,V,V>)](#computeifpresentkbifunctionkvv)

- [containsKey(Object)](#containskeyobject)

- [containsValue(Object)](#containsvalueobject)

- [entrySet()](#entryset)

- [equals(Object)](#equalsobject)

- [forEach(BiConsumer<K,V>)](#foreachbiconsumerkv)

- [get(Object)](#getobject)

- [getOrDefault(Object, V)](#getordefaultobject)

- [hashCode()](#hashcode)

- [isEmpty()](#isempty)

- [keySet()](#keyset)

- [merge(K,V,BiFunction<V,V,V>)](#mergekvbifunctionvvv)

- [put(K,V)](#putkv)

- [putAll(Map<K,V>)](#putallmapkv)

- [putIfAbsent(K,V)](#putifabsentkv)

- [remove(Object)](#removeobject)

- [remove(Object,Object)](#removeobjectobject)

- [replace(K,V,V)](#replacekvv)

- [replace(K,V)](#replacekv)

- [replaceAll(BiFunction<K,V,V>)](#replaceallbifunctionkvv)

- [size()](#size)

- [values()](#values)

# 方法详解

## <a id="clear">clear()</a>

源码：

```java
/**
 * Removes all of the mappings from this map (optional operation).
 * The map will be empty after this call returns.
 *
 * @throws UnsupportedOperationException if the <tt>clear</tt> operation
 *         is not supported by this map
 */
void clear();
```

功能：移除Map中所有的键值对。

## <a id="computekbifunctionkvv">compute(K,BiFunction<K,V,V>)</a>

源码：

```java
/**
 * Attempts to compute a mapping for the specified key and its current
 * mapped value (or {@code null} if there is no current mapping). For
 * example, to either create or append a {@code String} msg to a value
 * mapping:
 *
 * <pre> {@code
 * map.compute(key, (k, v) -> (v == null) ? msg : v.concat(msg))}</pre>
 * (Method {@link #merge merge()} is often simpler to use for such purposes.)
 *
 * <p>If the function returns {@code null}, the mapping is removed (or
 * remains absent if initially absent).  If the function itself throws an
 * (unchecked) exception, the exception is rethrown, and the current mapping
 * is left unchanged.
 *
 * @implSpec
 * The default implementation is equivalent to performing the following
 * steps for this {@code map}, then returning the current value or
 * {@code null} if absent:
 *
 * <pre> {@code
 * V oldValue = map.get(key);
 * V newValue = remappingFunction.apply(key, oldValue);
 * if (oldValue != null ) {
 *    if (newValue != null)
 *       map.put(key, newValue);
 *    else
 *       map.remove(key);
 * } else {
 *    if (newValue != null)
 *       map.put(key, newValue);
 *    else
 *       return null;
 * }
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties. In particular, all implementations of
 * subinterface {@link java.util.concurrent.ConcurrentMap} must document
 * whether the function is applied once atomically only if the value is not
 * present.
 *
 * @param key key with which the specified value is to be associated
 * @param remappingFunction the function to compute a value
 * @return the new value associated with the specified key, or null if none
 * @throws NullPointerException if the specified key is null and
 *         this map does not support null keys, or the
 *         remappingFunction is null
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</
 * @throws ClassCastException if the class of the specified key or value
 *         prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</
 * @since 1.8
 */
default V compute(K key,
        BiFunction<? super K, ? super V, ? extends V> remappingFunction) {
    Objects.requireNonNull(remappingFunction);
    V oldValue = get(key);
    V newValue = remappingFunction.apply(key, oldValue);
    if (newValue == null) {
        // delete mapping
        if (oldValue != null || containsKey(key)) {
            // something to remove
            remove(key);
            return null;
        } else {
            // nothing to do. Leave things as they were.
            return null;
        }
    } else {
        // add or replace old mapping
        put(key, newValue);
        return newValue;
    }
}
```

功能：

- 根据指定的键和重新映射函数计算新值，并将新值存储到Map中。
- 如果键存在，则根据提供的函数计算新值并更新到Map中，然后返回新值；如果键不存在，则不执行任何操作。

## <a id="computeifabsentkfunctionkv">computeIfAbsent(K,Function<K,V>)</a>

源码：

```java
/**
 * If the specified key is not already associated with a value (or is mapped
 * to {@code null}), attempts to compute its value using the given mapping
 * function and enters it into this map unless {@code null}.
 *
 * <p>If the function returns {@code null} no mapping is recorded. If
 * the function itself throws an (unchecked) exception, the
 * exception is rethrown, and no mapping is recorded.  The most
 * common usage is to construct a new object serving as an initial
 * mapped value or memoized result, as in:
 *
 * <pre> {@code
 * map.computeIfAbsent(key, k -> new Value(f(k)));
 * }</pre>
 *
 * <p>Or to implement a multi-value map, {@code Map<K,Collection<V>>},
 * supporting multiple values per key:
 *
 * <pre> {@code
 * map.computeIfAbsent(key, k -> new HashSet<V>()).add(v);
 * }</pre>
 *
 *
 * @implSpec
 * The default implementation is equivalent to the following steps for this
 * {@code map}, then returning the current value or {@code null} if now
 * absent:
 *
 * <pre> {@code
 * if (map.get(key) == null) {
 *     V newValue = mappingFunction.apply(key);
 *     if (newValue != null)
 *         map.put(key, newValue);
 * }
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties. In particular, all implementations of
 * subinterface {@link java.util.concurrent.ConcurrentMap} must document
 * whether the function is applied once atomically only if the value is not
 * present.
 *
 * @param key key with which the specified value is to be associated
 * @param mappingFunction the function to compute a value
 * @return the current (existing or computed) value associated with
 *         the specified key, or null if the computed value is null
 * @throws NullPointerException if the specified key is null and
 *         this map does not support null keys, or the mappingFunction
 *         is null
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the class of the specified key or value
 *         prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @since 1.8
 */
default V computeIfAbsent(K key,
        Function<? super K, ? extends V> mappingFunction) {
    Objects.requireNonNull(mappingFunction);
    V v;
    if ((v = get(key)) == null) {
        V newValue;
        if ((newValue = mappingFunction.apply(key)) != null) {
            put(key, newValue);
            return newValue;
        }
    }
    return v;
}
```

功能：

- 如果指定键不存在，则根据指定的映射函数计算并将结果存储到Map中；如果键已经存在，则不执行任何操作。
- 这个方法允许根据键的不存在来动态计算值，并将计算结果存储到Map中。

## <a id="computeifpresentkbifunctionkvv">computeIfPresent(K,BiFunction<K,V,V>)</a>

源码：

```java
/**
 * If the value for the specified key is present and non-null, attempts to
 * compute a new mapping given the key and its current mapped value.
 *
 * <p>If the function returns {@code null}, the mapping is removed.  If the
 * function itself throws an (unchecked) exception, the exception is
 * rethrown, and the current mapping is left unchanged.
*
 * @implSpec
 * The default implementation is equivalent to performing the following
 * steps for this {@code map}, then returning the current value or
 * {@code null} if now absent:
 *
 * <pre> {@code
 * if (map.get(key) != null) {
 *     V oldValue = map.get(key);
 *     V newValue = remappingFunction.apply(key, oldValue);
 *     if (newValue != null)
 *         map.put(key, newValue);
 *     else
 *         map.remove(key);
 * }
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties. In particular, all implementations of
 * subinterface {@link java.util.concurrent.ConcurrentMap} must document
 * whether the function is applied once atomically only if the value is not
 * present.
 *
 * @param key key with which the specified value is to be associated
 * @param remappingFunction the function to compute a value
 * @return the new value associated with the specified key, or null if none
 * @throws NullPointerException if the specified key is null and
 *         this map does not support null keys, or the
 *         remappingFunction is null
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the class of the specified key or value
 *         prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @since 1.8
 */
default V computeIfPresent(K key,
        BiFunction<? super K, ? super V, ? extends V> remappingFunction) {
    Objects.requireNonNull(remappingFunction);
    V oldValue;
    if ((oldValue = get(key)) != null) {
        V newValue = remappingFunction.apply(key, oldValue);
        if (newValue != null) {
            put(key, newValue);
            return newValue;
        } else {
            remove(key);
            return null;
        }
    } else {
        return null;
    }
}
```

功能：

- 如果指定键存在，则根据提供的重新映射函数计算新值，并将新值存储到Map中；如果键不存在，则不执行任何操作。
- 这个方法允许在键存在时根据原始值计算新值，并更新到Map中。

## <a id="containskeyobject">containsKey(Object)</a>

源码：

```java
/**
 * Returns <tt>true</tt> if this map contains a mapping for the specified
 * key.  More formally, returns <tt>true</tt> if and only if
 * this map contains a mapping for a key <tt>k</tt> such that
 * <tt>(key==null ? k==null : key.equals(k))</tt>.  (There can be
 * at most one such mapping.)
 *
 * @param key key whose presence in this map is to be tested
 * @return <tt>true</tt> if this map contains a mapping for the specified
 *         key
 * @throws ClassCastException if the key is of an inappropriate type for
 *         this map
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key is null and this map
 *         does not permit null keys
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 */
boolean containsKey(Object key);
```

功能：判断Map中是否包含指定的键。

## <a id="containsvalueobject">containsValue(Object)</a>

源码：

```java
/**
 * Returns <tt>true</tt> if this map maps one or more keys to the
 * specified value.  More formally, returns <tt>true</tt> if and only if
 * this map contains at least one mapping to a value <tt>v</tt> such that
 * <tt>(value==null ? v==null : value.equals(v))</tt>.  This operation
 * will probably require time linear in the map size for most
 * implementations of the <tt>Map</tt> interface.
 *
 * @param value value whose presence in this map is to be tested
 * @return <tt>true</tt> if this map maps one or more keys to the
 *         specified value
 * @throws ClassCastException if the value is of an inappropriate type for
 *         this map
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified value is null and this
 *         map does not permit null values
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 */
boolean containsValue(Object value);
```

功能：判断Map中是否包含指定的值。

## <a id="entrySet">entrySet()</a>

源码：

```java
/**
 * Returns a {@link Set} view of the mappings contained in this map.
 * The set is backed by the map, so changes to the map are
 * reflected in the set, and vice-versa.  If the map is modified
 * while an iteration over the set is in progress (except through
 * the iterator's own <tt>remove</tt> operation, or through the
 * <tt>setValue</tt> operation on a map entry returned by the
 * iterator) the results of the iteration are undefined.  The set
 * supports element removal, which removes the corresponding
 * mapping from the map, via the <tt>Iterator.remove</tt>,
 * <tt>Set.remove</tt>, <tt>removeAll</tt>, <tt>retainAll</tt> and
 * <tt>clear</tt> operations.  It does not support the
 * <tt>add</tt> or <tt>addAll</tt> operations.
 *
 * @return a set view of the mappings contained in this map
 */
Set<Map.Entry<K, V>> entrySet();
```

功能：返回一个包含Map中所有键值对的Set集合。

## <a id="equalsobject">equals(Object)</a>

源码：

```java
/**
 * Compares the specified object with this map for equality.  Returns
 * <tt>true</tt> if the given object is also a map and the two maps
 * represent the same mappings.  More formally, two maps <tt>m1</tt> and
 * <tt>m2</tt> represent the same mappings if
 * <tt>m1.entrySet().equals(m2.entrySet())</tt>.  This ensures that the
 * <tt>equals</tt> method works properly across different implementations
 * of the <tt>Map</tt> interface.
 *
 * @param o object to be compared for equality with this map
 * @return <tt>true</tt> if the specified object is equal to this map
 */
boolean equals(Object o);
```

功能：比较两个 `Map` 对象是否相等。两个 `Map` 相等的条件是：

1. 两个 `Map` 对象具有相同的键值对数量。

2. 对于每个键，两个 `Map` 对象的键值必须相等。

## <a id="foreachbiconsumerkv">forEach(BiConsumer<K,V>)</a>

源码：

```java
/**
 * Performs the given action for each entry in this map until all entries
 * have been processed or the action throws an exception.   Unless
 * otherwise specified by the implementing class, actions are performed in
 * the order of entry set iteration (if an iteration order is specified.)
 * Exceptions thrown by the action are relayed to the caller.
 *
 * @implSpec
 * The default implementation is equivalent to, for this {@code map}:
 * <pre> {@code
 * for (Map.Entry<K, V> entry : map.entrySet())
 *     action.accept(entry.getKey(), entry.getValue());
 * }</pre>
 *
 * The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
 *
 * @param action The action to be performed for each entry
 * @throws NullPointerException if the specified action is null
 * @throws ConcurrentModificationException if an entry is found to be
 * removed during iteration
 * @since 1.8
 */
default void forEach(BiConsumer<? super K, ? super V> action) {
    Objects.requireNonNull(action);
    for (Map.Entry<K, V> entry : entrySet()) {
        K k;
        V v;
        try {
            k = entry.getKey();
            v = entry.getValue();
        } catch(IllegalStateException ise) {
            // this usually means the entry is no longer in the map.
            throw new ConcurrentModificationException(ise);
        }
        action.accept(k, v);
    }
}
```

功能：对Map中的每个键值对执行指定的操作。

## <a id="getobject">get(Object)</a>

源码：

```java
/**
 * Returns the value to which the specified key is mapped,
 * or {@code null} if this map contains no mapping for the key.
 *
 * <p>More formally, if this map contains a mapping from a key
 * {@code k} to a value {@code v} such that {@code (key==null ? k==null :
 * key.equals(k))}, then this method returns {@code v}; otherwise
 * it returns {@code null}.  (There can be at most one such mapping.)
 *
 * <p>If this map permits null values, then a return value of
 * {@code null} does not <i>necessarily</i> indicate that the map
 * contains no mapping for the key; it's also possible that the map
 * explicitly maps the key to {@code null}.  The {@link #containsKey
 * containsKey} operation may be used to distinguish these two cases.
 *
 * @param key the key whose associated value is to be returned
 * @return the value to which the specified key is mapped, or
 *         {@code null} if this map contains no mapping for the key
 * @throws ClassCastException if the key is of an inappropriate type for
 *         this map
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key is null and this map
 *         does not permit null keys
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 */
V get(Object key);
```

功能：获取指定键对应的值，如果键不存在，则返回null。

## <a id="getordefaultobject">getOrDefault(Object, V)</a>

源码：

```java
/**
 * Returns the value to which the specified key is mapped, or
 * {@code defaultValue} if this map contains no mapping for the key.
 *
 * @implSpec
 * The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
 *
 * @param key the key whose associated value is to be returned
 * @param defaultValue the default mapping of the key
 * @return the value to which the specified key is mapped, or
 * {@code defaultValue} if this map contains no mapping for the key
 * @throws ClassCastException if the key is of an inappropriate type for
 * this map
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key is null and this map
 * does not permit null keys
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @since 1.8
 */
default V getOrDefault(Object key, V defaultValue) {
    V v;
    return (((v = get(key)) != null) || containsKey(key))
        ? v
        : defaultValue;
}
```

功能：获取指定键对应的值，如果键不存在，则返回指定的默认值。

## <a id="hashcode">hashCode()</a>

源码：

```java
/**
 * Returns the hash code value for this map.  The hash code of a map is
 * defined to be the sum of the hash codes of each entry in the map's
 * <tt>entrySet()</tt> view.  This ensures that <tt>m1.equals(m2)</tt>
 * implies that <tt>m1.hashCode()==m2.hashCode()</tt> for any two maps
 * <tt>m1</tt> and <tt>m2</tt>, as required by the general contract of
 * {@link Object#hashCode}.
 *
 * @return the hash code value for this map
 * @see Map.Entry#hashCode()
 * @see Object#equals(Object)
 * @see #equals(Object)
 */
int hashCode();
```

功能：返回 `Map` 对象的哈希码。

## <a id="isempty">isEmpty()</a>

源码：

```java
/**
 * Returns <tt>true</tt> if this map contains no key-value mappings.
 *
 * @return <tt>true</tt> if this map contains no key-value mappings
 */
boolean isEmpty();
```

功能：判断Map是否为空

## <a id="keyset">keySet()</a>

源码：

```java
/**
 * Returns a {@link Set} view of the keys contained in this map.
 * The set is backed by the map, so changes to the map are
 * reflected in the set, and vice-versa.  If the map is modified
 * while an iteration over the set is in progress (except through
 * the iterator's own <tt>remove</tt> operation), the results of
 * the iteration are undefined.  The set supports element removal,
 * which removes the corresponding mapping from the map, via the
 * <tt>Iterator.remove</tt>, <tt>Set.remove</tt>,
 * <tt>removeAll</tt>, <tt>retainAll</tt>, and <tt>clear</tt>
 * operations.  It does not support the <tt>add</tt> or <tt>addAll</tt>
 * operations.
 *
 * @return a set view of the keys contained in this map
 */
Set<K> keySet();
```

功能：返回 `Map` 中所有键的 `Set` 集合

## <a id="mergekvbifunctionvvv">merge(K,V,BiFunction<V,V,V>)</a>

源码：

```java
/**
 * If the specified key is not already associated with a value or is
 * associated with null, associates it with the given non-null value.
 * Otherwise, replaces the associated value with the results of the given
 * remapping function, or removes if the result is {@code null}. This
 * method may be of use when combining multiple mapped values for a key.
 * For example, to either create or append a {@code String msg} to a
 * value mapping:
 *
 * <pre> {@code
 * map.merge(key, msg, String::concat)
 * }</pre>
 *
 * <p>If the function returns {@code null} the mapping is removed.  If the
 * function itself throws an (unchecked) exception, the exception is
 * rethrown, and the current mapping is left unchanged.
 *
 * @implSpec
 * The default implementation is equivalent to performing the following
 * steps for this {@code map}, then returning the current value or
 * {@code null} if absent:
 *
 * <pre> {@code
 * V oldValue = map.get(key);
 * V newValue = (oldValue == null) ? value :
 *              remappingFunction.apply(oldValue, value);
 * if (newValue == null)
 *     map.remove(key);
 * else
 *     map.put(key, newValue);
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties. In particular, all implementations of
 * subinterface {@link java.util.concurrent.ConcurrentMap} must document
 * whether the function is applied once atomically only if the value is not
 * present.
 *
 * @param key key with which the resulting value is to be associated
 * @param value the non-null value to be merged with the existing value
 *        associated with the key or, if no existing value or a null value
 *        is associated with the key, to be associated with the key
 * @param remappingFunction the function to recompute a value if present
 * @return the new value associated with the specified key, or null if no
 *         value is associated with the key
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the class of the specified key or value
 *         prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key is null and this map
 *         does not support null keys or the value or remappingFunction is
 *         null
 * @since 1.8
 */
default V merge(K key, V value,
        BiFunction<? super V, ? super V, ? extends V> remappingFunction) {
    Objects.requireNonNull(remappingFunction);
    Objects.requireNonNull(value);
    V oldValue = get(key);
    V newValue = (oldValue == null) ? value :
               remappingFunction.apply(oldValue, value);
    if(newValue == null) {
        remove(key);
    } else {
        put(key, newValue);
    }
    return newValue;
}
```

功能：将指定的键和值合并到Map中，根据提供的函数计算新值。

## <a id="putkv">put(K,V)</a>

源码：

```java
/**
 * Associates the specified value with the specified key in this map
 * (optional operation).  If the map previously contained a mapping for
 * the key, the old value is replaced by the specified value.  (A map
 * <tt>m</tt> is said to contain a mapping for a key <tt>k</tt> if and only
 * if {@link #containsKey(Object) m.containsKey(k)} would return
 * <tt>true</tt>.)
 *
 * @param key key with which the specified value is to be associated
 * @param value value to be associated with the specified key
 * @return the previous value associated with <tt>key</tt>, or
 *         <tt>null</tt> if there was no mapping for <tt>key</tt>.
 *         (A <tt>null</tt> return can also indicate that the map
 *         previously associated <tt>null</tt> with <tt>key</tt>,
 *         if the implementation supports <tt>null</tt> values.)
 * @throws UnsupportedOperationException if the <tt>put</tt> operation
 *         is not supported by this map
 * @throws ClassCastException if the class of the specified key or value
 *         prevents it from being stored in this map
 * @throws NullPointerException if the specified key or value is null
 *         and this map does not permit null keys or values
 * @throws IllegalArgumentException if some property of the specified key
 *         or value prevents it from being stored in this map
 */
V put(K key, V value);
```

功能：将指定的键值对添加到Map中。

## <a id="putallmapkv">putAll(Map<K,V>)</a>

源码：

```java
/**
 * Copies all of the mappings from the specified map to this map
 * (optional operation).  The effect of this call is equivalent to that
 * of calling {@link #put(Object,Object) put(k, v)} on this map once
 * for each mapping from key <tt>k</tt> to value <tt>v</tt> in the
 * specified map.  The behavior of this operation is undefined if the
 * specified map is modified while the operation is in progress.
 *
 * @param m mappings to be stored in this map
 * @throws UnsupportedOperationException if the <tt>putAll</tt> operation
 *         is not supported by this map
 * @throws ClassCastException if the class of a key or value in the
 *         specified map prevents it from being stored in this map
 * @throws NullPointerException if the specified map is null, or if
 *         this map does not permit null keys or values, and the
 *         specified map contains null keys or values
 * @throws IllegalArgumentException if some property of a key or value in
 *         the specified map prevents it from being stored in this map
 */
void putAll(Map<? extends K, ? extends V> m);
```

功能：将指定Map中的所有键值对添加到当前Map中。

## <a id="putifabsentkv">putIfAbsent(K,V)</a>

源码：

```java
/**
 * If the specified key is not already associated with a value (or is mapped
 * to {@code null}) associates it with the given value and returns
 * {@code null}, else returns the current value.
 *
 * @implSpec
 * The default implementation is equivalent to, for this {@code
 * map}:
 *
 * <pre> {@code
 * V v = map.get(key);
 * if (v == null)
 *     v = map.put(key, value);
 *
 * return v;
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
 *
 * @param key key with which the specified value is to be associated
 * @param value value to be associated with the specified key
 * @return the previous value associated with the specified key, or
 *         {@code null} if there was no mapping for the key.
 *         (A {@code null} return can also indicate that the map
 *         previously associated {@code null} with the key,
 *         if the implementation supports null values.)
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the key or value is of an inappropriate
 *         type for this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key or value is null,
 *         and this map does not permit null keys or values
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws IllegalArgumentException if some property of the specified key
 *         or value prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @since 1.8
 */
default V putIfAbsent(K key, V value) {
    V v = get(key);
    if (v == null) {
        v = put(key, value);
    }
    return v;
}
```

功能：将指定的键值对添加到Map中，但仅当指定的键在Map中不存在时。

## <a id="removeobject">remove(Object)</a>

源码：

```java
/**
 * Removes the mapping for a key from this map if it is present
 * (optional operation).   More formally, if this map contains a mapping
 * from key <tt>k</tt> to value <tt>v</tt> such that
 * <code>(key==null ?  k==null : key.equals(k))</code>, that mapping
 * is removed.  (The map can contain at most one such mapping.)
 *
 * <p>Returns the value to which this map previously associated the key,
 * or <tt>null</tt> if the map contained no mapping for the key.
 *
 * <p>If this map permits null values, then a return value of
 * <tt>null</tt> does not <i>necessarily</i> indicate that the map
 * contained no mapping for the key; it's also possible that the map
 * explicitly mapped the key to <tt>null</tt>.
 *
 * <p>The map will not contain a mapping for the specified key once the
 * call returns.
 *
 * @param key key whose mapping is to be removed from the map
 * @return the previous value associated with <tt>key</tt>, or
 *         <tt>null</tt> if there was no mapping for <tt>key</tt>.
 * @throws UnsupportedOperationException if the <tt>remove</tt> operation
 *         is not supported by this map
 * @throws ClassCastException if the key is of an inappropriate type for
 *         this map
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key is null and this
 *         map does not permit null keys
 * (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 */
V remove(Object key);
```

功能：移除Map中指定键对应的值。

## <a id="removeobjectobject">remove(Object,Object)</a>

源码：

```java
/**
 * Removes the entry for the specified key only if it is currently
 * mapped to the specified value.
 *
 * @implSpec
 * The default implementation is equivalent to, for this {@code map}:
 *
 * <pre> {@code
 * if (map.containsKey(key) && Objects.equals(map.get(key), value)) {
 *     map.remove(key);
 *     return true;
 * } else
 *     return false;
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
 *
 * @param key key with which the specified value is associated
 * @param value value expected to be associated with the specified key
 * @return {@code true} if the value was removed
 * @throws UnsupportedOperationException if the {@code remove} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the key or value is of an inappropriate
 *         type for this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key or value is null,
 *         and this map does not permit null keys or values
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @since 1.8
 */
default boolean remove(Object key, Object value) {
    Object curValue = get(key);
    if (!Objects.equals(curValue, value) ||
        (curValue == null && !containsKey(key))) {
        return false;
    }
    remove(key);
    return true;
}
```

功能：移除Map中指定键对应的值，仅当该键关联的值与指定值相等时才移除。

## <a id="replacekvv">replace(K,V,V)</a>

源码：

```java
/**
 * Replaces the entry for the specified key only if currently
 * mapped to the specified value.
 *
 * @implSpec
 * The default implementation is equivalent to, for this {@code map}:
 *
 * <pre> {@code
 * if (map.containsKey(key) && Objects.equals(map.get(key), value)) {
 *     map.put(key, newValue);
 *     return true;
 * } else
 *     return false;
 * }</pre>
 *
 * The default implementation does not throw NullPointerException
 * for maps that do not support null values if oldValue is null unless
 * newValue is also null.
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
 *
 * @param key key with which the specified value is associated
 * @param oldValue value expected to be associated with the specified key
 * @param newValue value to be associated with the specified key
 * @return {@code true} if the value was replaced
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the class of a specified key or value
 *         prevents it from being stored in this map
 * @throws NullPointerException if a specified key or newValue is null,
 *         and this map does not permit null keys or values
 * @throws NullPointerException if oldValue is null and this map does not
 *         permit null values
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws IllegalArgumentException if some property of a specified key
 *         or value prevents it from being stored in this map
 * @since 1.8
 */
default boolean replace(K key, V oldValue, V newValue) {
    Object curValue = get(key);
    if (!Objects.equals(curValue, oldValue) ||
        (curValue == null && !containsKey(key))) {
        return false;
    }
    put(key, newValue);
    return true;
}
```

功能：将Map中指定键对应的旧值替换为新值，仅当键对应的值与旧值相等时才替换。

## <a id="replacekv">replace(K,V)</a>

源码：

```java
/**
 * Replaces the entry for the specified key only if it is
 * currently mapped to some value.
 *
 * @implSpec
 * The default implementation is equivalent to, for this {@code map}:
 *
 * <pre> {@code
 * if (map.containsKey(key)) {
 *     return map.put(key, value);
 * } else
 *     return null;
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
  *
 * @param key key with which the specified value is associated
 * @param value value to be associated with the specified key
 * @return the previous value associated with the specified key, or
 *         {@code null} if there was no mapping for the key.
 *         (A {@code null} return can also indicate that the map
 *         previously associated {@code null} with the key,
 *         if the implementation supports null values.)
 * @throws UnsupportedOperationException if the {@code put} operation
 *         is not supported by this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ClassCastException if the class of the specified key or value
 *         prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified key or value is null,
 *         and this map does not permit null keys or values
 * @throws IllegalArgumentException if some property of the specified key
 *         or value prevents it from being stored in this map
 * @since 1.8
 */
default V replace(K key, V value) {
    V curValue;
    if (((curValue = get(key)) != null) || containsKey(key)) {
        curValue = put(key, value);
    }
    return curValue;
}
```

功能：将Map中指定键对应的值替换为新值，返回旧值。

## <a id="replaceallbifunctionkvv">replaceAll(BiFunction<K,V,V>)</a>

源码：

```java
/**
 * Replaces each entry's value with the result of invoking the given
 * function on that entry until all entries have been processed or the
 * function throws an exception.  Exceptions thrown by the function are
 * relayed to the caller.
 *
 * @implSpec
 * <p>The default implementation is equivalent to, for this {@code map}:
 * <pre> {@code
 * for (Map.Entry<K, V> entry : map.entrySet())
 *     entry.setValue(function.apply(entry.getKey(), entry.getValue()));
 * }</pre>
 *
 * <p>The default implementation makes no guarantees about synchronization
 * or atomicity properties of this method. Any implementation providing
 * atomicity guarantees must override this method and document its
 * concurrency properties.
 *
 * @param function the function to apply to each entry
 * @throws UnsupportedOperationException if the {@code set} operation
 * is not supported by this map's entry set iterator.
 * @throws ClassCastException if the class of a replacement value
 * prevents it from being stored in this map
 * @throws NullPointerException if the specified function is null, or the
 * specified replacement value is null, and this map does not permit null
 * values
 * @throws ClassCastException if a replacement value is of an inappropriate
 *         type for this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if function or a replacement value is null,
 *         and this map does not permit null keys or values
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws IllegalArgumentException if some property of a replacement value
 *         prevents it from being stored in this map
 *         (<a href="{@docRoot}/java/util/Collection.html#optional-restrictions">optional</a>)
 * @throws ConcurrentModificationException if an entry is found to be
 * removed during iteration
 * @since 1.8
 */
default void replaceAll(BiFunction<? super K, ? super V, ? extends V> function) {
    Objects.requireNonNull(function);
    for (Map.Entry<K, V> entry : entrySet()) {
        K k;
        V v;
        try {
            k = entry.getKey();
            v = entry.getValue();
        } catch(IllegalStateException ise) {
            // this usually means the entry is no longer in the map.
            throw new ConcurrentModificationException(ise);
        }
        // ise thrown from function is not a cme.
        v = function.apply(k, v);
        try {
            entry.setValue(v);
        } catch(IllegalStateException ise) {
            // this usually means the entry is no longer in the map.
            throw new ConcurrentModificationException(ise);
        }
    }
}
```

功能：对Map中的每个键值对执行指定的替换操作。

## <a id="size">size()</a>

源码：

```java
/**
 * Returns the number of key-value mappings in this map.  If the
 * map contains more than <tt>Integer.MAX_VALUE</tt> elements, returns
 * <tt>Integer.MAX_VALUE</tt>.
 *
 * @return the number of key-value mappings in this map
 */
int size();
```

功能：返回Map中键值对的数量。

## <a id="values">values()</a>

源码：

```java
/**
 * Returns a {@link Collection} view of the values contained in this map.
 * The collection is backed by the map, so changes to the map are
 * reflected in the collection, and vice-versa.  If the map is
 * modified while an iteration over the collection is in progress
 * (except through the iterator's own <tt>remove</tt> operation),
 * the results of the iteration are undefined.  The collection
 * supports element removal, which removes the corresponding
 * mapping from the map, via the <tt>Iterator.remove</tt>,
 * <tt>Collection.remove</tt>, <tt>removeAll</tt>,
 * <tt>retainAll</tt> and <tt>clear</tt> operations.  It does not
 * support the <tt>add</tt> or <tt>addAll</tt> operations.
 *
 * @return a collection view of the values contained in this map
 */
Collection<V> values();
```

功能：返回包含Map中所有值的Collection集合。
