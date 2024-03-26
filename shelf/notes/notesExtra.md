## Dot Net Related - Frontend

<details>

<summary>.Net Razor Pages</summary>

***Main Razor Syntax Rules for C#***

+ Razor code blocks are enclosed in : ```@{ ... }```
+ Inline expressions (variables and functions) start with : ```@```
+ Code statements end with semicolon : ```;```
+ Variables are declared with the var keyword : ```var```
+ Strings are enclosed with quotation marks : ```""```
+ C# code is case sensitive
+ C# files have the extension .cshtml

<details>

<summary>Code Example</summary>

```C#
@{ var myMessage = "Hello World"; }
<p>The value of myMessage is: @myMessage</p>

@{
var greeting = "Welcome to our site!";
var weekDay = DateTime.Now.DayOfWeek;
var greetingMessage = greeting + " Here in Huston it is: " + weekDay;
}
<p>The greeting is: @greetingMessage</p>

//arrays
@{
string[] members = {"Jani", "Hege", "Kai", "Jim"};
int i = Array.IndexOf(members, "Kai")+1;
int len = members.Length;
string x = members[2-1];
}

//if else
@{var price=50;}
@if (price>30)
  {
  <p>The price is too high.</p>
  }
else
  {
  <p>The price is OK.</p>
  }

//loops
@for(var i = 10; i < 21; i++)
    {<p>Line @i</p>}
@foreach (var x in Request.ServerVariables)
    {<li>@x</li>}
@{
var i = 0;
while (i < 5)
    {
    i += 1;
    <p>Line @i</p>
    }
}

//switch
@{
var weekday=DateTime.Now.DayOfWeek;
var day=weekday.ToString();
var message="";
}
@switch(day)
{
case "Monday":
    message="This is the first weekday.";
    break;
case "Thursday":
    message="Only one day before weekend.";
    break;
case "Friday":
    message="Tomorrow is weekend!";
    break;
default:
    message="Today is " + day;
    break;
}
<p>@message</p>

```

</details>




</details>

## Angular JS - Frontend

<details>

<summary>Angular JS</summary>

***Concepts***

+ extends HTML with ng-directives.

+ ng-app defines AngularJS application.

+ ng-model binds HTML controls (input, select, textarea) values to application data. (input to var)

+ ng-bind binds application data to the HTML. (var to html display)

+ ng-init initializes AngularJS application data (var)

<details>

<summary>Code Example</summary>

```js
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

<div ng-app="">
  <p>Name: <input type="text" ng-model="name"></p>
  <p ng-bind="name"></p>
</div>

//ng-init

<div ng-app="" ng-init="firstName='John'">
<p>The name is <span ng-bind="firstName"></span></p>
</div>

```

</details>




</details>

## Server Related
<details>

<summary>Request Flow - App and Server</summary>

1. Users access websites through domain names, such as api.mysite.com. Usually, the Domain Name System (DNS) is a paid service provided by 3rd parties and not hosted by our servers.

2. Internet Protocol (IP) address is returned to the browser or mobile app. In the example, IP address 15.125.23.214 is returned.

3. Once the IP address is obtained, Hypertext Transfer Protocol (HTTP) [1] requests are sent directly to your web server.

4. The web server returns HTML pages or JSON response for rendering.

5. Reference : https://bytebytego.com/courses/system-design-interview/scale-from-zero-to-millions-of-users

</details>