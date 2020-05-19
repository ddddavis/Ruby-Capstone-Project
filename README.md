[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]


<br />
<p align="center">
  <a href="https://github.com/davisdambis/Ruby-Capstone-Project/feature">
    <img src="logo/microverse.png" alt="Logo" width="100" height="100">
  </a>

  <h2 align="center">Javascript Linter</h2>

  <h3 align="center">Ruby Capstone Project --> Build your own linter<h3>
  <p align="center">
    <a href="https://github.com/davisdambis/Ruby-Capstone-Project/feature"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    -
    <a href="https://github.com/davisdambis/Ruby-Capstone-Project/issues">Report Bug</a>
    -
    <a href="https://github.com/davisdambis/Ruby-Capstone-Project/issues">Request Feature</a>
    -
  </p>
</p>


## Table of Contents

* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Instructions](#instructions)
* [Contributors](#contributors)
* [Acknowledgements](#acknowledgements)
* [License](#license)


## About The Project

This is the **Ruby Capstone Project** required at the end of **Ruby** module in Microverse Curriculum.
It is a **Javascript Linter** with the purpose to check for simple Javascript errors


## Rules

**Strict Mode**

Strict mode helps out in a couple ways:

* It catches some common coding bloopers, throwing exceptions.
* It prevents, or throws errors, when relatively "unsafe" actions are taken (such as gaining access to the global object).
* It disables features that are confusing or poorly thought out.

Bad code:
```js
a = "Hello World!";
console.log(a)
}
```

The above code will work because it is not in strict mode.

Good code:
```js
"use strict";
a = "Hello World"; // Will throw a 'ReferenceError' because "a" is used without declaration
console.log(a);
```

**Relational Operators**

It is considered good practice to use the type-safe equality operators '===' and '!==' instead of their regular counterparts '==' and '!='.

For instance:

```js
  false == '0'      // true
  false == 'false'  // false
  1 == '1'          // true
  0 == ''           // true
  0 == '0'          // true
  3 == '03'         // true
```

Bad code:
```js
a == b
foo == true
bananas != 1
value == undefined
typeof foo == 'undefined'
'hello' != 'world'
0 == 0
true == true
foo == null
```

Good code:
```js
a === b
foo === true
bananas !== 1
value === undefined
typeof foo === 'undefined'
'hello' !== 'world'
0 === 0
true === true
foo === null
```

**Variable Declaration**

ECMAScript 6 allows programmers to create variables with block scope instead of function scope using the 'let' and 'const' keywords. Block scope is common in many other programming languages and helps programmers to avoid mistake such as:

```js
var count = people.length;
var enoughFood = count > sandwiches.length;

if (enoughFood) {
    var count = sandwiches.length; // accidentally overriding the count variable
    console.log("We have " + count + " sandwiches for everyone. Plenty for all!");
}

console.log("We have " + count + " people and " + sandwiches.length + " sandwiches!"); // our count variable is no longer accurate
```

Bad code:
```js
var x = "y";
var CONFIG = {};
```

Good code:
```js
let x = "y";
const CONFIG = {};
```

**Newline at the end of files**

Trailing newlines in non-empty files are a common UNIX idiom. Benefits of trailing newlines include the ability to concatenate or append to files as well as output files to the terminal without interfering with shell prompts.

Bad code:
```js
function doesSomething() {
  const foo = 2;
}
```

Good code:
```js
function doesSomething() {
  const foo = 2;
}

```

**Spacing**

Consistency is an important part of any style guide. While it is a personal preference where to put the opening brace of blocks, it should be consistent across a whole project. Having an inconsistent style distracts the reader from seeing the important parts of the code.

Bad code:
```js
if(variable2===variable3){
  console.log(true);
}else if(variable2!==variable3){
  console.log(false)
}else{
  console.log(false)
}
```

Good code:
```js
if (variable2 === variable3) {
  console.log(true);
} else if (variable2 !== variable3){
  console.log(false)
} else {
  console.log(false)
}
```


## Instructions

To test out **Javascript Linter** you need to:

* have **Ruby** installed on your computer
* [download](https://github.com/davisdambis/Ruby-Capstone-Project/archive/feature.zip) or clone this repo:
  - Clone with SSH:

  ```
  git@github.com:davisdambis/Ruby-Capstone-Project.git

  ```
  - Clone with HTTPS:

  ```
  https://github.com/davisdambis/ruby-capstone-project.git
  ```

* Navigate to root directory of the repo and run:

```
$ ruby /bin/main.rb path_to_file.js
```


**Rspec testing**

* Run the command and see the output
```
$ rspec
```

### Built With
This project was built using these technologies.
* Ruby
* Rubocop
* Rspec
* Strscan


## Contributors

👤 **Davis Dambis**

- GitHub: [@davisdambis](https://github.com/davisdambis)


## Acknowledgements

* [Microverse](https://www.microverse.org/)
* [The Odin Project](https://www.theodinproject.com/)
* [Ruby Documentation](https://www.ruby-lang.org/en/documentation/)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/davisdambis/ruby-capstone-project.svg?style=flat-square
[contributors-url]: https://github.com/davisdambis/ruby-capstone-project/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/davisdambis/ruby-capstone-project.svg?style=flat-square
[forks-url]: https://github.com/davisdambis/ruby-capstone-project/network/members
[stars-shield]: https://img.shields.io/github/stars/davisdambis/ruby-capstone-projectr.svg?style=flat-square
[stars-url]: https://github.com/davisdambis/ruby-capstone-project/stargazers
[issues-shield]: https://img.shields.io/github/issues/davisdambis/ruby-capstone-project.svg?style=flat-square
[issues-url]: https://github.com/davisdambis/ruby-capstone-project/issues

## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.