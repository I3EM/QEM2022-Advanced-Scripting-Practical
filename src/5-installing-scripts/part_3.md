# Reconstructing the Image

```admonish info
For this section, we will need the <a href="../dmscripts/mystery_unswap.s" download>following library file</a>.
```

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class swap focus
    class polynomial,mtf,tag,pspec,gspec,maxs,rand,mean,rand_vec done
```

In this section, we will perform the last step of image reconstruction, with the
help of an external function that we will install.

The goal this time is not to build the function ourselves, but rather to learn how
to install a script persistently, for other scripts to use. This is necessary in order
to be able to reuse software.

```admonish tip
You should try to split your software in as many units of logic as possible. You
may then put those separate bits of logic in different (properly named) functions.
It is not an easy task, and it may require taking a step back, but it is worth it.

This approach has several benefits:
1. It makes us write code that is easier to read, by separating your main task in
   several subtasks (that may be then separated in subsubtasks and so on).
2. It makes us write code that may be reusable, so we or other people may
   build upon it instead of systematically reinventing the wheel.
3. It also means that we have only one place to modify if we want to improve
   a function that is used by several scripts
<!--
Compare for example:
```java
Image src := getfrontimage()

Image fft := realfft(src) * exp(-4 * icol**2 - 4 * irow**2)
``` -->
```

## Installing and Uninstalling a Script

In order to integrate our scripts in Digital Micrograph,
we have the option of installing them persistently.

Digital Micrograph gives us two option:

1. We may install our script as a menu item, which will allow us to
   run our script each time we click on the item. Using this, we will
   have quick access to our processings.

2. We may install our script as a library, which helps in making our functions
   available to other scripts. The script will be automatically executed at
   start-up, and every global state and function will be kept in memory until
   shutdown (or explicit removal).

   This mode may also be used for arbitrary code execution at start-up, for example
   to automatically setup a connection with our microscope, to print some instrument
   state in the `Results` window, to open the last closed image...

~~~admonish tip title="Installing a script as a library" collapsible=true
1. Make sure your script is open in Digital Micrograph.
2. Click on your script, to make sure it is selected.
3. Go to `File > Install Script...`.
4. Click on the `Library` tab.
5. *(Optional)* Rename your library on the text field if need be.
6. Select either `Install for the current user only` or `Install for all users`,
   depending on your needs.
7. Click `Ok`.

<video controls>
    <source src="install_library.mp4" type="video/mp4">
    <track label="English" kind="subtitles" srclang="en" src="install_library.vtt" default>

    Sorry, your browser doesn't support embedded videos.
</video>
~~~

~~~admonish tip title="Installing a script as a menu item" collapsible=true
1. Make sure your script is open in Digital Micrograph.
2. Click on your script, to make sure it is selected.
3. Go to `File > Install Script...`.
4. Rename your command on the `Name of command?` text field.
5. Name the menu to put your command in the `Which menu?` text field.
6. *(Optional)* Name a submenu to put your command in the `Optional submenu?` text field.
7. Select either `Install for the current user only` or `Install for all users`,
   depending on your needs.
8. Click `Ok`.

<video controls>
    <source src="install_menu.mp4" type="video/mp4">
    <track label="English" kind="subtitles" srclang="en" src="install_menu.vtt" default>

    Sorry, your browser doesn't support embedded videos.
</video>
~~~

~~~admonish tip title="Removing a script" collapsible=true
1. Go to `File > Remove Script...`.
2. If your script was installed for all users, click on the `All Users` tab,
   otherwise stay here.
3. Select your script on the list.
4. Click `Remove`.

<video controls>
    <source src="removing_a_script.mp4" type="video/mp4">
    <track label="English" kind="subtitles" srclang="en" src="removing_a_script.vtt" default>

    Sorry, your browser doesn't support embedded videos.
</video>
~~~

## Installing the Mystery Unswap

If you did not already, download the <a href="../dmscripts/mystery_unswap.s" download>library file</a>.
Then install it *as a library*, following the explanations from the previous section.

You may then use it with the following line:

```java
{{#include ../dmscripts/solution_appl3.s}}
```

```admonish warning
Please do not forget to uninstall the `mystery_unswap` script be fore leaving,
so that your classmates may reinstall it without trouble.
```

## Final Proposed Implementation

```admonish warning
A solution to the problem is given below.
Before consulting it, we encourage you to make your own tries.
```

~~~admonish example title="Solution" collapsible=true
```java
{{#include ../dmscripts/solution.s}}
```
~~~