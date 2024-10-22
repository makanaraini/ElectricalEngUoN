To compare the attributes of the filters described in your previous laboratory exercises, we will focus on the following aspects: **order**, **zeros**, **poles**, **stability**, **phase response**, and **magnitude response**. We will compare the following filters:

1. **FIR Filter** (Rectangular filter with windowing)
2. **IIR Filter** (Butterworth, Chebyshev Type I, and Chebyshev Type II filters)

### 1. FIR Filter (Rectangular Filter with Windowing)

#### Attributes:
- **Order**: The order of the FIR filter is determined by the number of taps (coefficients). For the rectangular filter, the order is \( N - 1 \) (where \( N \) is the number of points). In this case, \( N = 25 \), so the order is 24.
- **Zeros**: The zeros of the FIR filter can be calculated from the filter coefficients. For a rectangular filter, the zeros will be distributed in the z-plane.
- **Poles**: FIR filters have no poles (or all poles are at the origin), which means they are stable by design.
- **Stability**: FIR filters are inherently stable since they do not have feedback elements.
- **Phase Response**: The phase response of FIR filters can be linear, depending on the design. However, rectangular filters typically have a non-linear phase response.
- **Magnitude Response**: The magnitude response of the rectangular filter shows a main lobe with significant side lobes, which can be reduced by applying a window.

### 2. IIR Filters (Butterworth, Chebyshev Type I, Chebyshev Type II)

#### Attributes:
- **Order**: The order of IIR filters is determined by the design specifications. For example, if the Butterworth filter has an order of 4, the Chebyshev Type I filter has an order of 3, and the Chebyshev Type II filter has an order of 5, these values will vary based on the design criteria.
- **Zeros**: IIR filters can have both zeros and poles. The zeros are determined by the filter design and can be calculated from the transfer function.
- **Poles**: IIR filters have poles that can be located anywhere in the z-plane. The stability of the filter depends on the location of these poles.
- **Stability**: IIR filters can be stable or unstable. For stability, all poles must lie inside the unit circle in the z-plane. If any pole lies on or outside the unit circle, the filter is unstable.
- **Phase Response**: The phase response of IIR filters can be non-linear, and it may introduce phase distortion, especially near the cutoff frequency.
- **Magnitude Response**: The magnitude response of IIR filters can be sharper than that of FIR filters, allowing for steeper roll-offs. However, they may also exhibit ripples in the pass-band (especially Chebyshev filters).

### Summary Comparison Table

| Attribute                | FIR Filter (Rectangular) | IIR Filter (Butterworth) | IIR Filter (Chebyshev Type I) | IIR Filter (Chebyshev Type II) |
|--------------------------|--------------------------|--------------------------|-------------------------------|---------------------------------|
| **Order**                | 24                       | 4                        | 3                             | 5                               |
| **Zeros**                | Distributed in z-plane   | Calculated from design   | Calculated from design        | Calculated from design          |
| **Poles**                | None (or at origin)      | Located in z-plane       | Located in z-plane            | Located in z-plane              |
| **Stability**            | Stable                   | Can be stable/unstable   | Can be stable/unstable        | Can be stable/unstable          |
| **Phase Response**       | Non-linear               | Non-linear               | Non-linear                    | Non-linear                      |
| **Magnitude Response**   | Main lobe with side lobes| Smooth roll-off          | Ripple in pass-band           | Flat pass-band with ripple      |

### Conclusion
- **FIR Filters**: The FIR filter (rectangular) is stable and has a simple structure with no poles. However, it may have a less sharp roll-off compared to IIR filters.
- **IIR Filters**: The IIR filters (Butterworth, Chebyshev Type I, and Chebyshev Type II) can achieve sharper roll-offs and are more efficient in terms of order. However, they require careful design to ensure stability, and they may introduce phase distortion.

This comparison highlights the trade-offs between FIR and IIR filters, helping you choose the appropriate filter type based on your specific application requirements.