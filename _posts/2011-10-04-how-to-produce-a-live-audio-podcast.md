---
layout: post
title:  How to Produce a Live Audio Podcast
date:   2011-10-04
categories:
  - Podcasting
permalink: /how-to-produce-a-live-audio-podcast/
redirect_from:
  - /2011/10/how-to-produce-live-audio-podcast.html
thumb:
  path: /assets/posts/how-to-produce-a-live-audio-podcast/PodcastMicrophone.png
  alt: picture of a condencer microphone with a pop filter on a boom arm
lede:
  Producing a live web-radio show in podcast form has never been more accessible. It can still be daunting to figure out how to get up and running. This guide will show you how to get up and running with your podcast using Windows. No offense to Mac folks, but this is what I use for thEndUsr podcast and what I have experience with. I use a program called Virtual Audio Cables to route audio. You can converse over Skype and live stream it to the world. Easily said right?
---
{% include post_image.md name="PodcastMicrophone.png" %}

Producing a live web-radio show in podcast form has never been more accessible. It can still be daunting to figure out how to get up and running. This guide will show you how to get up and running with your podcast using Windows. No offense to Mac folks, but this is what I use for [thEndUsr podcast](https://thedigitalmediazone.com/podcasts/thendusr/) and what I have experience with. I use a program called [Virtual Audio Cables](https://software.muzychenko.net/eng/vac.html) to route audio. You can converse over Skype and live stream it to the world. Easily said right?

Here is the software you will need to get. Since everything except for Virtual Audio Cables is modular, you can swap out any of these programs with any counterpart that does the same thing. However, I will provide screenshots for these programs:

* [Skype](http://www.skype.com/)
* [Audacity](http://audacity.sourceforge.net/)
* [Virtual Audio Cables](http://software.muzychenko.net/eng/vac.htm) ($30, free trial)
* [Ustream website](http://www.ustream.tv/) or the [Ustream producer App](http://www.ustream.tv/producer)

Despite the setup being entirely virtual, you can think of this as a series of inputs and outputs that are connected via the virtual audio cables. You will need to set up 3 virtual audio cables. We will only use 2, but a 3rd may come in handy. I will refer to these as VAC’s from now on.

### Virtual Audio Cables Setup

First we need to set up the VAC’s.

* Open the Start Menu and navigate to >All Programs>Virtual Audio Cable>Control Panel
* Open up the VAC Control Panel as an Admin by right clicking on “Control Panel” and clicking “Run as Administrator”
* In the Control Panel set “Cables” in the upper left to 3 and click “Set”

{% include post_image.md name="vacControlPanel14.png" %}

* Close the Control Panel by clicking “Exit”

You will now notice that there are new audio devices in the Recording and Playback tab of the sound panel (right click on the speaker icon in the tray to get the Recording devices and the Playback devices).

{% include post_image.md name="audioDev6.png" %}

Next you will have to set your audio cables to route the sound around for you. To do so you open what VAC calls an “Audio Repeater.” It is also found in the start menu. Open the MME type, not the KS type. As you can see below, you get an input and an output per Audio Repeater. You can open as many of these as you like.

{% include post_image.md name="repeater1.png" %}

Let’s take a break from VAC for a second and set up our Skype, Audacity and Ustream.

### Skype Setup

Here I am using Skype 5.1. It may look a little different with future updates.

* Open the Skype options by clicking Tools>Options, then click “Audio Settings” on the left
* Set the input Microphone as your microphone – in my case, it is my Mbox
* Set the output or Speakers as your second VAC “Line 2”
* Uncheck “Automatically adjust speaker settings”

{% include post_image.md name="skypeOptions4.png" %}

* Click “Save” and Skype is all set!

### Audacity Setup

Here I am using Audacity 1.3 Beta. It may look a little different with future updates.

* Open the Audacity preferences by clicking Edit>Preferences
* Under the “Devices” tab, set playback “Device” to your speakers or headphones
* Under “recording,” set the Device to Line 1 and Channels to 1 (Mono)

{% include post_image.md name="Audacity1.png" %}

* Click “Ok” to save and Audacity is set to record!

### Putting it Together

We now have Skype set to hear the microphone and output to VAC “Line 2,” and Audacity to record on VAC “Line 1” and output to your speakers or headphones for editing later. Here is where we use VAC to make them talk to each other. Open 3 audio repeaters as mentioned earlier.

* Set one VAC to route in mono from your mic to Line 1
* Set one VAC to route in stereo from Line 2 to Line 1
* Set one VAC to route in stereo from Line 2 to your speakers or headphones
* Click “Start” on all of the repeaters
* Feel free to minimize all of them

{% include post_image.md name="repeater11.png" %}

The screenshot shows the settings for all of the repeaters. This may seem like voodoo so let me explain. Your mic (in my case it is an mbox) gets piped into Line 1. Line 2 is the Skype in stereo which is also piped into Line 1. This makes a mix of me and my co-hosts on Skype. Line 2, which is Skype, gets piped into my speakers or headphones so I can hear my co-hosts. This is the mix minus you have been looking for. One last thing to note is that my mic is mono and Skype is stereo. Be careful to make sure the VAC that Skype goes into is stereo. All the audio routing is done here.

* Place a Skype call
* Hit record in Audacity when you want to start recording

Now we have your mic and Skype piped into Line 1. Remember we set Audacity to record on Line 1, so effectively we are recording the conversation. Here is a higher-level diagram of how the routing works.

{% include post_image.md name="vacflowDiagram.png" %}

One more tip about the Audio Repeaters: they have a command line switch so it is easy to write a simple script to launch them all automatically. For my setup, the script looks like this:

start C:”Program Files””Virtual Audio Cable”audiorepeater.exe /ChanCfg:”mono” /Input:”Digidesign Mbox2 Analog 1/2 (3-” /Output:”Line 1 (Virtual Audio Cable)” /AutoStart

start C:”Program Files””Virtual Audio Cable”audiorepeater.exe /ChanCfg:”stereo” /Input:”Line 2 (Virtual Audio Cable)” /Output:”Line 1 (Virtual Audio Cable)” /AutoStart

start C:”Program Files””Virtual Audio Cable”audiorepeater.exe /ChanCfg:”stereo” /Input:”Line 2 (Virtual Audio Cable)” /Output:”Speakers (High Definition Audio” /AutoStart

Copy and paste that into notepad and replace the input and output for each cable. To get the exact name of the input and output, you will need to copy down exactly what it says in the “Wave in” and “Wave out” section from the audio repeater as seen above. For the first VAC in my example that was “Digidesign Mbox2 Analog 1/2(3-” which is my microphone as we discussed earlier, and as the diagram illustrates. Save that text file as a cmd file. Something like “podcast.cmd” would work. Taking the first command (of three), that starts a VAC in mono with the right input and output and autostarts it when you double-click on the script’s icon. Cool, huh? Don’t worry, if the script is too complicated you can do it manually every time and it will still work. The script sure does save a lot of time, though.

### Ustream Setup

We are almost there. We can now start the live stream. I will use Ustream as the example, but any live streaming service like [Justin.tv](http://www.justin.tv/), [Mixlr](http://mixlr.com/) or [Livestream](http://www.livestream.com/) will work as long as you set the input to VAC 1. After you have set up the Skype routing and everything is set you are ready for the live stream to begin.

* Go to [https://www.ustream.tv/](http://www.ustream.tv/)
* Login and click “Go Live!” in the upper right hand corner

{% include post_image.md name="ustream8.png" %}

* Set “Audio Source” to “Line 1” to broadcast both sides of the Skype conversation
* Click “Start Broadcast” and “Start Record”
* The final and hardest step is to actually podcast! Have fun!

You can broadcast your local webcam video if you would like. If do not want any video, untick the “Video Broadcast” box. The “Start Record” button can act as a backup recording in case Audacity crashes. If Audacity crashes you can download and convert an FLV file from Ustream and post it to your podcast feed as if nothing happened. I will post an additional post on how to record a full video podcast using the same tools plus one extra tool. I can only hope that this guide has helped someone unlock the technical side of podcasting to produce some great content. Podcast away! See you on the net-waves.
