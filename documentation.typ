= Bosque Language Reference

= Index
The Bosque language documentation is split into multiple sections as follows:
1. [Expressions]-- contains the core language expressions and their semantics.
2. [Statements] -- contains the core language statements and their semantics.
3. [Types] -- contains the core language types and their semantics.
4. [Structures] -- contains the core language declarations/structures and their semantics.

The standard libraries are documented in the libraries section. 
5. [Core] -- contains the core language standard library.
6. [List] -- contains the list standard library.

Tooling such as compilers and checkers are documented in the tools section.


= Introduction
Bosque is a new approach to programming models, development tooling, and 
runtime design that is focused on supporting mechanization at scale and 
establishing a new standard for creating high-reliability software artifacts. 
The foundational design precepts for Bosque are:

- *Design for Tooling & Mechanization*
The entire system should be amenable to automated analysis and transformation.
Avoid features or behaviors that inhibit analysis and automation.

- *Total Safety*
Don't just make mistakes hard to make, eliminate them entirely. Whenever 
possible rule-out entire categories of failures by construction.

- *WYSIWYG* 
Humans and AI Agents understand and make assumptions about the semantics (
behavior) of the code from the textual representation (syntax). Minimize the 
presence of implicit or syntactically hidden behaviors.

- *The Ecosystem is the Language* 
Modern development at scale is a collaborative process, both working with 
partner teams or using 3rd party code, via packages and/or APIs. Create a 
framework that is designed for componentization, composition, and behavioral 
guarantees.

- *Reliable Performance at Scale* 
At scale worst-case performance behaviors will inevitably occur and are 
problematic to resolve. Design for low-variance execution and minimize the 
impacts of worst case behaviors instead of optimizing for the best or average 
case.

- *Failure is Always an Option*
Failure is inevitable and mitigation/recovery is a requirement for reliable 
and scalable systems. Give un-happy path processing first-class support in the 
language and ensure observability throughout the system.



= Type System
- Type System
  1. Primitive Types
  2. Structural Types
  3. Enum Types
  4. Type Aliases
  5. Concept Types
  6. Entity Types
  7. Algebraic Types
  8. Validator Types
  9. Typed Strings
  10. Path Types
  11. Special Types
  12. Task Types
- Type Checker
  1. Subtyping
  2. Implicit Type Coercion
  3. Explicit Type Coercion
  4. Type Inference
  5. Explicit Flow Typing


== Primitives
#table(
  columns: (auto,auto,auto,2fr),
  align: horizon,
  table.header(
    [Type],[Syntax],[Size],[Description]
  ),
  [Int], [22i], [4bytes],[Unsigned 63-bit integers. Ensures a safe negation and cast to `Nat`.],
  [BigInt], [20I], [any bytes],[Arbitary precision unsigned integers.],
  [Nat], [12n], [4bytes],[Signed 63-bit integers. Ensures a safe negation and cast to `Int`.],
  [BigNat], [33N], [any bytes],[Arbitary precision signed integers.],
  [String], [*"*hello*"*], [any bytes],[Values of only Unicode characters.],
  [CString], [*'*hello*'*], [any bytes],[Values of only UTF-8 characters.],
  [ Bool ], [true,false],[1 byte],[ Values of `true` or `false`. ],
  [ None ], [none], [any bytes],[ Value of `none`. ],
  [ Float], [18f], [64-bit], [Base-2 IEEE-754 (style) floating point numbers. Infinity/NaN are errors.],
  [ Decimal], [52d], [dunno], [50-digit base-10 floating point number (TODO: currently `cpp_dec_float_50`).],
  [ Rational], [72R], [dunno], [Fraction with BigInt numerator and Nat rounding denominator.],
  [DecimalDegree], [TODO], [TODO],[ A decimal degree value in the range [-180, 180]],
  [LatLongCoordinate], [TODO], [TODO], [A pair of DecimalDegree values for latitude and longitude. ],
  [Complex], [TODO], [TODO], [A pair of Float values for real and imaginary parts.],
)
//TODO
- Type Checker
  1. Subtyping
  2. Implicit Type Coercion
  3. Explicit Type Coercion
  4. Type Inference
  5. Explicit Flow Typing

= Expressions

Let -> Immutability

Var -> Mutability

- Pure Bosque Expressions
    1. Literals
    2. Parameters/Variables/Captures
    3. Literal StringOf Expressions
    4. Literal Typed Expressions
    5. Namespace Constants
    6. Member Constants
    7. Tuple Constructors
    8. Record Constructors
    9. Entity Constructors
    10. Special Constructors
    11. Collection Constructors
    12. Namespace and Member Functions
    13. Namespace Operators
    14. Logical And/Or 
    15. Tuple Index Access
    16. Record Property Access
    17. Field Access
    18. ITest Check
    19. ITest As and Conversion
    20. Method Call
    21. Method Call Virtual
    22. Prefix `!` operator
    23. Prefix numeric `-` operator
    24. Binary numeric arithmetic, `+`/`-`/`*`/`/` operators
    25. Binary numeric comparison `==`/`!=`/`<`/`<=`/`>`/`>=` operators
    26. Binary KeyType equality `===`/`!==` operators
    27. Binary Logic `&&`/`||`/`==>` operators
    28. MapEntry Constructor `=>` operator
    29. If-Then-Else Expression
    30. Switch Expression
    31. Match Expression
    32. [TODO] Task Expressions
- Bosque Expression Components
    1. ITests
    2. Arguments
    3. Binders
    4. Lambdas
    5. Direct Literals
    6. Regular Expressions
    7. Path Expressions
- Bosque Task Expressions
    1. Format Arguments
    2. Environment Variables


= Statements

    1. Empty Statement
    2. Variable Declaration
    3. Variable Assignment
    4. Variable Re-Type
    5. Return Statement
    6. If-Else Statement
    7. Switch Statement
    8. Match Statement
    9. Abort Statement
    10. Assert Statement
    11. Validate Statement
    12. Debug Statement

= Structures
Namespaces and packages

= Standard Library

= Lists
- List Type
- List Global Functions
- List Member Functions
- List Member Methods
    1. size/empty
    2. get/front/back
    3. allOf/noneOf/someOf
    4. contains
    5. find/findIndexOf
    6. filter/filterType
    7. castType
    8. map/project
    9. append/prepend
    10. pushBack/pushFront
    11. popBack/popFront
    12. set/insert/remove
    13. zip/zipWith
    14. join/group
    15. reduce

// # List Type
// # List Global Functions
// # List Member Functions
//
// # List Member Methods
//
// ## size/empty
// The `size` and `empty` operators return the number of elements in the list and whether the list is empty respectively.
//
// ```none
// let l1 = List<Nat>{};
// l1.size() //0
// l1.empty() //true
//
// let l2 = List<Nat>{1n, 2n, 3n};
// l2.size() //3
// l2.empty() //false
// ```
//
// ## get/front/back
// The `get`, `front` and `back` operators return the element at the specified index, the first element and the last element respectively. Index out of bounds or calling `front`/`back` on an empty list will result in a runtime error.
//
// ```none
// let l1 = List<Nat>{1n, 2n, 3n};
// l1.get(0n) //1n
// l1.get(1n) //2n
// l1.get(2n) //3n
//
// l1.front() //1n
// l1.back() //3n
//
// let l2 = List<Nat>{};
// l2.get(0n) //error
// l2.front() //error
// l2.back() //error
// ```
//
// ## allOf/noneOf/someOf
// Bosque provides the `allOf`, `noneOf` and `someOf` operators to test whether all, none, or some of the elements in the list satisfy a predicate. The predicate is a function that takes an element of the list and returns a `Bool`. There are 2 flavors of these methods. In one flavor the predicate is a single argument function that just takes the element. The other flavors, `allOfIdx`, `noneOfIdx`, and `someOfIdx`, the predicate is a 2 argument function that takes the element and the index of the element in the list. 
//
// ```none
// let l1 = List<Nat>{1n, 2n, 3n};
// l1.allOf(pred(e) => e > 0n) //true
// l1.noneOf(pred(e) => e > 0n) //false
//
// let l2 = List<Nat>{3n, 2n, 1n};
// l1.someOfIdx(pred(e, i) => e > 0n && i == 1n) //true
// l1.someOfIdx(pred(e, i) => e == l2.get(i)) //true
//
// let l3 = List<Nat>{};
// l3.allOf(pred(e) => e > 0n) //true
// l3.noneOf(pred(e) => e > 0n) //true
// l3.someOf(pred(e) => e > 0n) //false
// ```
//
// ## contains
// When the list contents type is a `KeyType` then the List supports a simplified `contains` method as well which returns true if the list contains the specified element (using the KeyType equals comparator).
//
// ```none
// let l = List<Int?>{1i, none, 3i};
// l.contains(3i) //true
// l.contains(2i) //false
// l.contains(none) //true
// ```
//
// ## find/findIndexOf
// The `find` and `findIndexOf` family of methods search a list for elements that satisfy a predicate. The `find` and `findIdx` methods return the first element in the list that satisfies the provided predicate (and result in a runtime error if no such element exists). The `findIndexOf` and `findIndexOfIdx` methods return the index of the first element in the list that satisfies the predicate (and result in a runtime error if no such element exists).
//
// ```none
// let l1 = List<Int>{1i, 2i, 3i};
// l1.find(pred(e) => e > 1i) //2i
// l1.findIndexOf(pred(e) => e > 1i) //1n
//
// l1.find(pred(e) => e > 10i) //error
// l1.findIndexOf(pred(e) => e > 10i) //error
//
// let l2 = List<Int>{0i, -2i, 0};
// l2.findIdx(pred(e, i) => e == -l1.get(i)) //1n
// ```
//
// ## filter/filterType
// The `filter`, `filterIdx`, and `FilterType` methods provide a way to filter a list based on a predicate. The `filter` and `filterIdx` methods return a new list that contains only the elements that satisfy the predicate. The `filterType` method returns a new list that contains only the elements that are of the specified type. 
//
// ```none
// let l1 = List<Int>{1i, -2i, 3i};
// l1.filter(pred(e) => e > 1i) //List<Int>{1i, 3i}
// l1.filter(pred(e) => e > 10i) //List<Int>{}
//
// let l2 = List<Int?>{0i, none, 5i};
// l2.filterType<Int>() //List<Int>{0i, 5i}
// ```
//
// ## castType
// The `castType` method returns a new list that contains only the elements that are of the specified type. If an element is not of the specified type then the result is a runtime error.
//
// ```none
// let l1 = List<Int?>{0i, 2i, 5i};
// l1.castType<Int>() //List<Int>{0i, 2i, 5i}
//
// let l2 = List<Int?>{0i, none, 5i};
// l2.castType<Int>() //error
// ```
//
// ## map/project
// The `map` and `project` families of methods provide ways to transform lists. The `map` families of operations take a function that maps elements of type `T` to elements of type `U`. The `project` families of operations take a `Map<T, V>` and use this to transform the elements in the list. If the map does not contain a key for an element in the list then the result is a runtime error.
//
// ```none
// let l = List<Int>{1i, 2i, 3i};
// l.map<Int>(fn(e) => e + 1i) //List<Int>{2i, 3i, 4i}
// l.mapIdx<Int>(fn(e, i) => e + i.toInt()) //List<Int>{1i, 3i, 5i}
// l.map<Int?>(fn(e) => if (e != 2i) then e else none) //List<Int?>{1i, none, 3i}
//
// let m = Map<Int, Int?>{1i => 2i, 2i => none, 3i => 4i};
// l.project<Int?>(m) //List<Int?>{2i, none, 4i}
//
// let merr = Map<Int, Int?>{1i => 2i, 4i => 5i};
// l.project<Int>(merr) //error -- missing key 2i
// ```
//
// ## append/prepend
// The `append` and `prepend` methods concatenate two lists together. The `append` method appends the second list to the first list. The `prepend` method prepends the second list to the first list.
//
// ```none
// let l1 = List<Int>{1i, 2i, 3i};
// let l2 = List<Int>{4i, 5i, 6i};
//
// l1.append(l2) //List<Int>{1i, 2i, 3i, 4i, 5i, 6i}
// l1.prepend(l2) //List<Int>{4i, 5i, 6i, 1i, 2i, 3i}
// ```
//
// ## pushBack/pushFront
// The `pushBack` and `pushFront` methods add an element to the end or beginning of a list. These methods return a new list and do not modify the original list.
//
// ```none
// let l = List<Int>{1i, 2i, 3i};
//
// l.pushBack(4i) //List<Int>{1i, 2i, 3i, 4i}
// l.pushFront(0i) //List<Int>{0i, 1i, 2i, 3i}
// ```
//
// ## popBack/popFront
// The `popBack` and `popFront` methods remove an element from the end or beginning of a list. These methods return a new list and do not modify the original list.
//
// ```none
// let l = List<Int>{1i, 2i, 3i};
//
// l.popBack() //List<Int>{1i, 2i}
// l.popFront() //List<Int>{2i, 3i}
// ```
//
// ## set/insert/remove
// Bosque lists support `set`, `insert`, and `remove` operations that return new versions of the collections with the needed updates. The `set` operation replaces the element at the specified index with the specified element. The `insert` operation inserts the specified element at the specified index. The `remove` operation removes the element at the specified index. Index out-of-bounds are runtime errors.
//
// ```none
// let l = List<Int>{1i, 2i, 3i};
//
// l.set(1n, 4i) //List<Int>{1i, 4i, 3i}
// l.insert(1n, 5i) //List<Int>{1i, 5i, 2i, 3i}
// l.remove(1n) //List<Int>{1i, 3i}
// ```
//
// ## zip/zipWith
// The `zip` and `zipWith` function combine two lists (of equal length) into a single list of tuples. The `zip` method combines two lists into a list of tuples. The `zipWith` method combines two lists into a list of values using the specified function.
//
// ```none
// let l1 = List<Int>{1i, 2i, 3i};
// let l2 = List<String>{"one", "two", "three"};
//
// ListOp::zip<Int, String>(l1, l2) //List<[Int, String]>{[1i, "one"], [2i, "two"], [3i, "three"]}
// ListOp::zipWith<Int, String, Bool>(l1, l2, fn(e1, e2) => e1 > 2 || e2 === "one") //List<Bool>{true, false, true}
// ```
//
// ## join/group
// The `join` and `group` functions combine two lists using algebraic products. The `join` method produces a list of tuples where the first element comes from the first list, the second element comes from the second list, and the predicate applied to them is true. The `group` method produces a list of tuples where the first element comes from the first list and the second element is a list of elements from the second list that satisfy the specified predicate.
//
// ```none
// let l1 = List<Int>{1i, 2i, 3i};
// let l2 = List<Int>{2i, 3i, 4i};
//
// ListOp::join<Int, Int>(l1, l2, fn(e1, e2) => e1 >= e2) //List<[Int, Int]>{[2i, 2i], [3i, 2i], [3i, 3i]}
// ListOp::group<Int, Int>(l1, l2, fn(e1, e2) => e1 >= e2) //List<[Int, List<Int>]>{[1i, List<Int>{}], [2i, List<Int>{2i}], [3i, List<Int>{2i, 3i}]}
// ```
//
// ## reduce
// The `reduce` operation applies a reduction function to the elements in the from left (min index) to right (max index) and returns the result. The reduction function takes the current result and the next element and returns the new result. The initial result is specified as the first argument to the `reduce` method.
//
// ```none
// let l = List<Int>{1i, 2i, 3i};
//
// l.reduce<Int>(0i, fn(r, e) => r + e) //6i
// l.reduceIdx<Int>(0i, fn(r, e, i) => r + e + i.toInt()) //9i
// ```
//
