# Comp 558

> [Course Website](http://cim.mcgill.ca/~langer/558.html)

## Lecture 1 - 2018/09/04

* Applications of Computer Vision
    * Image editing
    * Object scanning for 3D printing
    * Handwriting recognition
    * Face detection and recognition
    * Image search & retrieval
    * People detection and tracking
    * Navigations systems
    * Medical imaging
    * Biological imaging

## Lecture 2 - 2018/09/06
* 720p = 1MP; 1080p = 2MP
* #f0f magenta; #ff0 yellow; #0ff cyan
* The human eye has varying sensitivity to RGB at varying wavelengths
    * We are more sensitive to green
* Bayer pattern - checkerboard pattern of [G, R; B, G]
    * 50% G, 25% R, 25% B
* I<sub>RGB</sub>(x) = C<sub>RGB</sub>(&lambda;) S(x, &lambda;) d&lambda;
* Exposure<sub>RGB</sub>(x) = I<sub>RGB</sub>(x) * t
* Analog to digital conversion
    * gain control - adjust overall sensitivity of responses
    * white balance - adjust relative sensitivity of R, G, B