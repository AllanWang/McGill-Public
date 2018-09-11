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

## Lecture 3 - 2018/09/11

* Image noise - random variation of brightness or color information; usually electronic noise
* Image smoothing - averaging the intensities of RGBs to reduce noise
* Local average (1D) - I<sub>smooth</sub>(x) =  &frac14; I(x + 1) + &frac12; I(x) +  &frac14; I(x - 1)
* Smoothing an edge will decrease the slope of steps, which blends the edge colors.
* Gaussian function: G(x) = (1/ sqrt(2 &pi;) &sigma;) e^-(x^2/(2 &sigma;^2))
    * Integrates to 1
    * Often called normal distribution
    * Can use it for smoothing weights
    * The bigger the &sigma;, the more smoothing there is
* Local difference: dI(x)/dx m &approx; &frac12; I(x + 1) - &frac12; I(x - 1)
* Cross correlation: f(x) cross I(x) &equiv; &Sigma;<sub>u</sub> f(u - x) I(u)
    * Sliding a template across an image, and taking the inner product
    * Shows how well a filter matches the image
    * For the local average (1D)
        * f(x) = &frac14; when x = +1, -1
        * f(x) = &frac12; when x = 0
        * f(x) = 0 otherwise
* I is the image, f is the filter or kernel
* Convolution: f(x) * I(x) &equiv; &Sigma;<sub>u</sub> f(x - u) I(u)
    * Summing weighted, shifted versions of the function f
    * Shows how much image intensity contributes to the filtered output
* Impulse function: &sigma;(x) = 1 when x = 0, 0 otherwise
    * &sigma;(x) * I(x) = I(x)
    * Outputs an impulse response
