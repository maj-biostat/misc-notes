# Julia

- [Setup and start](#setup-and-start)
- [Variables (hello world)](#variables--hello-world-)
- [Data types](#data-types)
- [Casting](#casting)
- [Strings](#strings)
- [Conditional](#conditional)
- [Loop](#loop)
- [Array](#array)
- [Tuple](#tuple)
- [Dict](#dict)
- [Set](#set)
- [Functions](#functions)
- [Anon functions](#anon-functions)
- [Math](#math)
- [Enum](#enum)
- [Symbols](#symbols)
- [Struct](#struct)
- [Abstract type](#abstract-type)
- [Exception](#exception)
- [File IO](#file-io)
- [Macro](#macro)
- [Data types](#data-types-1)
- [Casting](#casting-1)
- [Strings](#strings-1)
- [Conditional](#conditional-1)
- [Loop](#loop-1)
- [Array](#array-1)
- [Tuple](#tuple-1)
- [Dict](#dict-1)
- [Set](#set-1)
- [Functions](#functions-1)
- [Anon functions](#anon-functions-1)
- [Math](#math-1)
- [Enum](#enum-1)
- [Symbols](#symbols-1)
- [Struct](#struct-1)
- [Abstract type](#abstract-type-1)
- [Exception](#exception-1)
- [File IO](#file-io-1)
- [Macro](#macro-1)



## Setup and start

Note that [neovim](neovim.md) and [tmux](multiplexer.md) contain some useful environment setup notes. 

Clear the repl.

```
julia> ;
shell> clear
```

To compile a file:

```
terminal$ julia file.jl
```

The following is mainly a condensed summary of a youtube tutorial [Julia Tutorial](https://www.youtube.com/watch?v=sE67bP2PnOo)

## Variables (hello world)

Types are dynamically assigned and are mutable (int to string).

```
# Bring in modules
using Printf
using Statistics

# Declare a variable and then update it - no problemo
s = 0
s = "Dog"# Introductory Julia
println(s)
```

However, note that you can assert different data types if you really want to.

## Data types

Basic types:

+ booleans (true or false)
+ various Int8, 16 etc, BigInts, the latter giving you increased precision.
+ various Float32, Float64, BigFloat
+ characters (text surrounded by single quote) 

## Casting

```
# From float to unsigned int.
i1 = UInt8(trunc(3.14))
println(i1)
# From string to float
f1 = parse(Float64, "22.9")
# barfs
i2 = parse(Int8, "22.9") 
# ok
i2 = parse(Int8, "22") 
```

## Strings

```
s1 = "Random string surrounded by double quote"
# Note use """blah blah ... """ if you have multiline strings to declare.
println(length(s1))
# index starts at 1
println(s1[1])
println(s1[end])
println(s1[1:4])
s2 = string("A", "Test")
println(s2)
println("A " * "Concatenation")
i3 = 2
i4 = 3
println("$i3 + $i4 = $(i3 + i4)")
# find index
println(findfirst(isequal('i'), "Trick"))
println(occursin("key", "monkey"))
```
## Conditional

```
# && || ! (and or not)
if x > 12 && y < 10
  println("hit it")
elseif age < 12
  println("wha")
else 
  println("y")
end
```

Ternery operator:

```
# condition ? "if true" : "if false"
true || false ? "true" : "false"
```

## Loop

```
i = 1
while i < 20
  if (i%2) == 0
    println(i)
    # access global outside loop
    global i += 1
    continue
  end
  global i += 1
  if i >= 10
    break
  end
end
```

```
for i = 1:5
  println(i)
end
for i in [2, 3, 5]
  println(i)
end
# j with a step
for i = 1:5, j = 2:2:10
  println((i, j))
end
```

## Array

```
# 2x2 array of int32
a1 = zeros(Int32, 2, 2)
a2 = Array{Int32}(undef, 5)
a3 = Float64[]
a4 = [1,2,3]
println(5 in a4)
# generic to use in findall
f(a) = (a >= 2) ? true : false
println(findall(f, a4))
# Count occurrences of
println(count(f, a4))

# Size, dim etc
println(size(a4))
println(length(a4))
println(sum(a4))
# Weird - Introduce 8 and 9 starting at index 2 in a4
splice!(a4, 2:1, [8,9])
println(a4)
# Now remove them
splice!(a4, 2:3)
println(maximum(a4))
println(minimum(a4))
# vector op
println(a4 * 2)
```

Store functions in an array.

```
a6 = [sin, cos, tab]
for i in a6
  print(i(0))
end
```

Multidim array

```
# define 2 x 4
a7 = [1 2 3 4; 5 6 7 8]
for i = 1:2, j = 1:4
  @printf("%d ", a7[i, j])
end

# second col
println(a7[:, 2])
# second row
println(a7[2, :])

# arrays from ranges
a8 = collect(1:5)
# step forward 2, 4, 6, ... (or backward with - as step)
a9 = collect(2:2:10)
# array from comprehension
a10 = [n^2 for n in 1:4]
# add a value to array
push!(a10, 25)
a11 = [n * m for n in 1:3, m in 1:5]
println(a11)
# random values
a12 = rand(0:9,3,5)
for n = 1:3
  for m = 1:5
    print(a12[n,m])
  end
  println()
end
```

## Tuple
Cannot be changed once defined.

```
t1 = (1, 2, 3, 4)
t2 = ((1, 2), (3, 4))
t3 = (sue = ("Sue", 100), paul = ("Paul", 23))
println(t3.sue)
```
## Dict

Key value pairs with unique keys.

```
d1 = Dict("pi"=> 3.14, "e"=>2.718)
println(d1["pi"])
d1["golden"] = 1.618
delete!(d1, "pi")
# does it have a key?
println(haskey(d1, "golden"))
# get the full thing
println(in("golden"=>1.618))
println(keys(d1))
println(values(d1))

for kv in d1
  println(kv)
end

for (key, value) in d1
  println(key, " : ", value)
end
```

## Set

## Functions

## Anon functions

## Math

## Enum

## Symbols

## Struct

## Abstract type

## Exception

## File IO

## Macro


## Data types

Basic types:

+ booleans (true or false)
+ various Int8, 16 etc, BigInts, the latter giving you increased precision.
+ various Float32, Float64, BigFloat
+ characters (text surrounded by single quote) 

## Casting

```
# From float to unsigned int.
i1 = UInt8(trunc(3.14))
println(i1)
# From string to float
f1 = parse(Float64, "22.9")
# barfs
i2 = parse(Int8, "22.9") 
# ok
i2 = parse(Int8, "22") 
```

## Strings

```
s1 = "Random string surrounded by double quote"
# Note use """blah blah ... """ if you have multiline strings to declare.
println(length(s1))
# index starts at 1
println(s1[1])
println(s1[end])
println(s1[1:4])
s2 = string("A", "Test")
println(s2)
println("A " * "Concatenation")
i3 = 2
i4 = 3
println("$i3 + $i4 = $(i3 + i4)")
# find index
println(findfirst(isequal('i'), "Trick"))
println(occursin("key", "monkey"))
```
## Conditional

```
# && || ! (and or not)
if x > 12 && y < 10
  println("hit it")
elseif age < 12
  println("wha")
else 
  println("y")
end
```

Ternery operator:

```
# condition ? "if true" : "if false"
true || false ? "true" : "false"
```

## Loop

```
i = 1
while i < 20
  if (i%2) == 0
    println(i)
    # access global outside loop
    global i += 1
    continue
  end
  global i += 1
  if i >= 10
    break
  end
end
```

```
for i = 1:5
  println(i)
end
for i in [2, 3, 5]
  println(i)
end
# j with a step
for i = 1:5, j = 2:2:10
  println((i, j))
end
```

## Array

```
# 2x2 array of int32
a1 = zeros(Int32, 2, 2)
a2 = Array{Int32}(undef, 5)
a3 = Float64[]
a4 = [1,2,3]
println(5 in a4)
# generic to use in findall
f(a) = (a >= 2) ? true : false
println(findall(f, a4))
# Count occurrences of
println(count(f, a4))

# Size, dim etc
println(size(a4))
println(length(a4))
println(sum(a4))
# Weird - Introduce 8 and 9 starting at index 2 in a4
splice!(a4, 2:1, [8,9])
println(a4)
# Now remove them
splice!(a4, 2:3)
println(maximum(a4))
println(minimum(a4))
# vector op
println(a4 * 2)
```

Store functions in an array.

```
a6 = [sin, cos, tab]
for i in a6
  print(i(0))
end
```

Multidim array

```
# define 2 x 4
a7 = [1 2 3 4; 5 6 7 8]
for i = 1:2, j = 1:4
  @printf("%d ", a7[i, j])
end

# second col
println(a7[:, 2])
# second row
println(a7[2, :])

# arrays from ranges
a8 = collect(1:5)
# step forward 2, 4, 6, ... (or backward with - as step)
a9 = collect(2:2:10)
# array from comprehension
a10 = [n^2 for n in 1:4]
# add a value to array
push!(a10, 25)
a11 = [n * m for n in 1:3, m in 1:5]
println(a11)
# random values
a12 = rand(0:9,3,5)
for n = 1:3
  for m = 1:5
    print(a12[n,m])
  end
  println()
end
```

## Tuple
Cannot be changed once defined.

```
t1 = (1, 2, 3, 4)
t2 = ((1, 2), (3, 4))
t3 = (sue = ("Sue", 100), paul = ("Paul", 23))
println(t3.sue)
```
## Dict

Key value pairs with unique keys.

```
d1 = Dict("pi"=> 3.14, "e"=>2.718)
println(d1["pi"])
d1["golden"] = 1.618
delete!(d1, "pi")
# does it have a key?
println(haskey(d1, "golden"))
# get the full thing
println(in("golden"=>1.618))
println(keys(d1))
println(values(d1))

for kv in d1
  println(kv)
end

for (key, value) in d1
  println(key, " : ", value)
end
```

## Set

## Functions

## Anon functions

## Math

## Enum

## Symbols

## Struct

## Abstract type

## Exception

## File IO

## Macro




