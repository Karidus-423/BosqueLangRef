# Bosque Programming Language
___

# Introduction
Bosque is a new approach to programming models, development tooling, and 
runtime design that is focused on supporting mechanization at scale and 
establishing a new standard for creating high-reliability software artifacts. 
The foundational design precepts for Bosque are:

- **Design for Tooling & Mechanization**

The entire system should be amenable to automated analysis and transformation.
Avoid features or behaviors that inhibit analysis and automation.

- **Total Safety**
    
Don't just make mistakes hard to make, eliminate them entirely. Whenever 
possible rule-out entire categories of failures by construction.

- **WYSIWYG** 
    
Humans and AI Agents understand and make assumptions about the semantics (
behavior) of the code from the textual representation (syntax). Minimize the 
presence of implicit or syntactically hidden behaviors.

- **The Ecosystem is the Language** 

Modern development at scale is a collaborative process, both working with 
partner teams or using 3rd party code, via packages and/or APIs. Create a 
framework that is designed for componentization, composition, and behavioral 
guarantees.

- **Reliable Performance at Scale** 

At scale worst-case performance behaviors will inevitably occur and are 
problematic to resolve. Design for low-variance execution and minimize the 
impacts of worst case behaviors instead of optimizing for the best or average 
case.

- **Failure is Always an Option**

Failure is inevitable and mitigation/recovery is a requirement for reliable 
and scalable systems. Give un-happy path processing first-class support in the 
language and ensure observability throughout the system.

# Language Reference

# Comments
Bosque currently supports one type of comments. That is the normal comments.
Using `//` to start them and end at the next EOL byte.

```bsq
// Ends at the next '\n'.
```

# Types

## Type System

The Bosque type system is designed to be expressive, flexible, and simple to 
use. It is based on a hybrid of object-orientated and functional programming 
concepts with a number of features adopted (and extended) from experience 
working with service base and cloud applications. Foundational concepts 
driving the type systems design are:

1) Prevent common programming errors, support IDE integration, and provide 
useful inline documentation. Some key features here include support for 
enhanced-ADTs, typed strings/paths, and lightweight typedecls over primitive 
types.
2) Avoid complex type-checking algorithms that are difficult to understand 
and slow to run, and ensure that, as the requirements for a program change,
the type system can be easily extended/modified to match. Features like 
Union- types and multiple-inheritance are examples that support this goal.

Types in Bosque should be obvious and easy to write/update, provide useful 
information to IDE tooling and other developers, prevent a wide range of common
errors, and then get out of the way!

### Type Primitives
For the set of builtin primitive types, Bosque looks broadly at the most common 
foundation types seen in modern programming, particularly looking toward 
cloud-dev, that we want to support directly such as BigInt and BigNat, UUIDs, 
or dates and times. Instead of forcing developers to manually define these 
types, or encode them as strings with a special structure, we provide them as 
primitives that have well known syntax and can be extended for domain specific 
concepts.

#### Unique Types

| Type | Description |
| -------------- | --------------- |
| None | Value of `none`. |
| Bool | Values of `true` or `false`. |

#### Integral Number Types

| Type | Description |
| -------------- | --------------- |
| Nat | Unsigned 63-bit integers. Ensures a safe cast to `Int`. |
| Int | Signed 63-bit integers. Ensures a safe negation and cast to `Nat`.  |
| BigNat | Arbitary precision unsigned integers. |
| BigInt | Arbitary precision signed integers. |


#### String Types

| Type | Description |
| -------------- | --------------- |
| String  | Values of only Unicode characters. Use of double quote `""`. |
| CString | Values of only ASCII characters. Use of single quote `''`.|


### Literals

- Only annotaded numeric literals are supported.

```bsq
// Valid -> assert value == 42i;
// Invalid -> assert value == 42;
```


## Type Checker


## Variables

```bsq
let bar: Nat = 32n;
let var = 32I;
```

## Methods

All methods are static by default.

# Operators

## Boolean Expressions

Bosque alternatives to representing boolean expressions from the usual.

| Expression | Regular | Alternative |
| --------------- | --------------- | --------------- |
| and | `&&` | /\\(statement1,statement2) |
| or | `\|\|` | \\/(statement1,statement2) |

## Comparison Expression

At the end of the day a comparison expression return a boolean. This is how
to express it in Bosque.

### Equals

`33n == 33n`
`-2i != -3i`

### Strict Equals

`0n === 3n`
`0n !== 0n`
`none === none`

### Ranges

`1n >= +3n`
`33i <= -10i`

### KeyComparator
//TODO:  LEFT OFF HERE
  


## Namespaces
Do declare namespaces we write the following at the top of the file.

```
declare namespace Main;
```
We are now able to declare variables to use on this namespace `Main`.

```
entity Bar { }

function main(): Option<Bar> {
    // Can use Option<Main::Bar> too.
    return none; 
}
```



### Namespace Import

We are able to import other namespaces and rename them if necessary.
```
declare namespace Main {
    using NSDiff; 
    using NSOther as Other; 
}
```

```
function main(): Option<Other::Bar> {
    return none; 
}
```


## Entities

```
entity Foo {
    field f: Int;
} 
```

To access the fields of an entity we do the following.

```
function main(x: Foo): Int {
    return x.f; 
}
```

A field update is done as such.

```
function main(): Int {
    //var v = Foo{1i};
    //return v[x = 2i].x; 
    // OR do this
    
    var v = Foo{1i};
    return v[x = $x + 1i].x;
}

```


## Enums

```
enum Foo {
    f1, F2, _f3
}
```

Enums are accessed as such.

```
return Foo#_f3;
```

## Assert

Boque provides *predicates* that should always be true, which are asserts.

//TODO: What does an assert do when it fails?

```bsq
function main(): Int{
    assert(true);
    assert false;
    
    //They can be tagged too.
    assert try false;
    assert spec true;
    
    return 33i;
}
```

## Debug

//TODO: WHAT IS THIS?

```
function main(): Int {
    _debug 5i;
    return 1i; 
}
```

## Binary Expressions

### Addition
They must be same type to work.

`0n + 1n` -> Output is Nat.
`34I + -1I` -> Output is BigInt.

### Subtraction

`+0N - 1N` -> Output is BigNat.
`32i - -1i` -> Output is Int.


### Division

`+66I // +2I` -> Output is BigInt
`+2i // -2i` -> Ouput is Int

### Multiplication

`11n * 3n` -> Output is Nat.
`2N * 12N` -> Ouput is BigNat.


## if

`if` expressions execute a code block if the condition is true.

```bsq
if (x >= 5){
    x = y;
}
```

# Bosque Standard Library
  

