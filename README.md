##  Terraform Training

If you'd prefer to learn a few of the basics via YouTube, check out the following link:

[Terraform Basics](https://www.youtube.com/watch?v=wybFGCultsk&list=PL8iDDHqmj1oW_JYcEfM21XI0cFnp5b9dP&index=1)

## What Is Terraform?
Terraform is an open-source infrastructure as code software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language (HCL), or optionally

## What Is HCL?

This low-level syntax of the Terraform language is defined in terms of a syntax called HCL, which is also used by configuration languages in other applications, and in particular other HashiCorp products. HCL was created to be human-readable and easier to work with instead of using JSON or YAML. HCL is a functional-based programming language

## Terraform Developer Concepts
- Immutable: Cannot be changed after a resource is created. Instead, it gets replaced/re-created.
- Mutable: Can be changed after a resource is created

## Terraform Terminology

### Programmatic Terminology
- Provider: Providers interact with sources (AWS, Azure, Cloudflare, etc.) at the programmatic level via API calls.
- Module: A folder that contains all of the Terraform resources that you're utilizing. For example, if you have a directory called *s3-bucket* and inside of it is a Terraform resource to create an S3 bucket, that would be a **Module**
- State: The `tfstate` is cached metadata about the configurations that are created/replaced/updated/delete in a Terraform module.
- Data Source: Return information on resources. For example, to return the metadata of an S3 bucket.
- Output Values: Values returned after creating resources via Terraform that can be used for other configurations or just as information.
 - Backend: Defines where and how operations are performed, where state snapshots are stored, etc.
 - Remote State: Store the state in a remote location (S3 bucket for example).

### Creating/Replacing/Updating/Deleted Terraform Resources
- Init: Initialize a Terraform module to be ready to create/replace/update/delete resources. `init` also downloads the Provider and stores it in the Terraform module.
- Plan: Determines what needs to be created/replaced/updated/deleted to move to the desired state.
- Apply: Creates/replaces/updates/deletes the resources via Terraform
- Destroy: Deletes the resources in the Terraform module
- Resources: A block of code to create/replace/update/delete services, servers, etc.. For example, an S3 bucket.



## Loops

A `for` loop creates a type value by transforming another type value. The verbiage is pretty much like:

"for `this thing` in `that thing` do something with the data

Example:
```
output "instances_by_availability_zone" {
  value = {
    for instance in aws_instance.example:
    instance.availability_zone => instance.id
  }
}
```

## Comparison/Conditionals (if statements)

A conditional expression (`if` statement in another languages) uses the value of a bool expression to select one of two values.

```
var.a != "" ? var.a : "default-a"
```

```
condition ? true_val : false_val
```

## Operators
Operators in Terraform are anything from "add these two values together" to "greater than, less than, or equal to". When thinking about operators, think mathematical operators.

Arithmetic operators in Terraform expect number values and in-turn ensures that the result is a number value

- a + b returns the result of adding a and b together.
- a - b returns the result of subtracting b from a.
- a * b returns the result of multiplying a and b.
- a / b returns the result of dividing a by b.
- a % b returns the remainder of dividing a by b. This operator is generally useful only when used with whole numbers.
- -a returns the result of multiplying a by -1.

The equality operators take two values of any type and produce boolean values as results.

- a == b returns true if a and b both have the same type and the same value, or false otherwise.
- a != b is the opposite of a == b.

The comparison operators expect number values and produce boolean values as results.

- a < b returns true if a is less than b, or false otherwise.
- a <= b returns true if a is less than or equal to b, or false otherwise.
- a > b returns true if a is greater than b, or false otherwise.
- a >= b returns true if a is greater than or equal to b, or false otherwise.

The logical operators expect bool values and produce bool values as results.

a || b returns true if either a or b is true, or false if both are false.
a && b returns true if both a and b are true, or false if either one is false.
!a returns true if a is false, and false if a is true.

## More Information
For more info, check out the following links:
- https://www.terraform.io/docs/language/expressions/operators.html
- https://www.terraform.io/docs/language/expressions/for.html
- https://www.terraform.io/docs/language/expressions/types.html
- https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each



## Types

- string: Unicode characters representing some text, like "hi terraform" " "hi".
- number (like an `int`): a numeric value. The number type can represent both whole numbers like 15 or 54 and fractional values like 6.28.
- bool: Either true or false.
- list (`tuple`): a sequence of values, like ["us-west-1a", "us-west-1c"]. Elements in a list or tuple are identified by consecutive whole numbers, starting with zero.
- map (or object): a group of values identified by named labels, like {name = "Mabel", age = 52}.


