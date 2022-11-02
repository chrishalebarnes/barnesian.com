---
layout: post
title:  Correctly Setting the Environment Variables for the Java JDK on Windows
date:   2011-02-18
categories:
  - Software
permalink: /correctly-setting-the-environment-variables-for-the-java-jdk-on-windows/
redirect_from:
  - /2011/02/correctly-setting-environment-variables.html
thumb:
  path: /assets/posts/correctly-setting-the-environment-variables-for-the-java-jdk-on-windows/JDK1.png
  alt: picture of setting environment variables on Windows
lede:
  Every time I go to install the Java JDK I forget about setting the environment variables. Inevitably compiling something with the “javac” command fails with the error message “‘javac’ is not recognized as an internal or external command, operable program or batch file” As if I had a mental lapse I can never remember how to fix this without heading to Google and figuring it out again. For one last time here is how to fix it. Head past the break to fix it by properly setting the buried System Environment Variables.
---
{% include post_image.md name="JDK1.png" %}

Every time I go to install the Java JDK I forget about setting the environment variables. Inevitably compiling something with the “javac” command fails with the error message “‘javac’ is not recognized as an internal or external command, operable program or batch file” As if I had a mental lapse I can never remember how to fix this without heading to Google and figuring it out again. For one last time here is how to fix it. Head past the break to fix it by properly setting the buried System Environment Variables.

1.  Open the start menu and type “system environment variables” and hit enter or open the start menu and navigate to Control Panel>System and Security>System>Advanced system settings(up and on the left). This action will open this window
{% include post_image.md name="JDK2.png" %}

2.  Click on Environment Variables to open this window.
{% include post_image.md name="JDK3.png" %}

3.  You want to edit the “Path” system variable. Scroll down a bit until you see “Path”. Highlight “Path” and click edit. That brings us to this window.
{% include post_image.md name="JDK5.png" %}

4.  The “Variable value” may have some stuff in it already. It is a series of different folder paths separated by a semicolon(no spaces before or after the semicolon!) You want to add the path where your java executibles are located. For me that is “C:Program FilesJavajdk1.6.0\_24bin” You will have to take a look and see where yours are. Add the path to the beginning of the “Variable value” box with a semicolon at the end without erasing what may already be there. Ensure there is no space before or after the semicolon. You will also need to add the “current directory” Otherwise you would get the error message java.lang.NoClassDefinitionFoundError . Do so by adding a period and a semicolon the the beginning. In the end it should look like this “.;C:Program FilesJavajdk1.6.0\_24bin;” There may be another path already there, do not worry about that and leave it alone.
5.  You should now be able to compile correctly from the command line by typing “javac” and then the name of the .java file.
6.  One more thing! If you stop here and you try to run the java program you may be confronted with this: “Exception in thread “main” java.lang.NoClassDefFoundError” Yikes!
{% include post_image.md name="JDK6.png" %}

7.  Make sure you are not putting “.java” on the end of the command. As in my example here it should be “java _program-name_” Also this may not happen, so see if java works first.
8.  Assuming it does not work you have to add the current directory into another System Environment Variable.
9.  Navigate to the same System Environment Variables spot from before. This time find the variable “CLASSPATH” like this:
{% include post_image.md name="JDK4.png" %}

10.  You want to add the “current directory” to the “CLASSPATH” So, go ahead highlight “CLASSPATH” hit edit and add “.;’” to the very beginning as displayed in the above image. If “CLASSPATH” is not there, then try creating it by hitting “New…” Click ‘ok’ twice and close the control panel if it is still open.

After those little modifications that are oh so easy to forget you should be able to compile and run your java program. Have fun!
{% include post_image.md name="JDK7.png" %}

Did I forget anything? Hit me up in the comments.



