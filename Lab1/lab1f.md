The stability of digital filters is primarily determined by the location of their poles in the z-plane. Here’s how to assess the stability of the filters \( H_1(z) \) and \( H_2(z) \) designed using impulse invariance and bilinear transform methods, respectively:

### Stability Criteria:
1. **Digital Filters**: A digital filter is stable if all its poles lie inside the unit circle in the z-plane. This means that the magnitude of each pole must be less than 1 (i.e., \( |P_i| < 1 \) for all poles \( P_i \)).
2. **Analogue Filters**: For analogue filters, stability is determined by the location of poles in the s-plane. A stable analogue filter has all poles in the left half of the s-plane.

### Analysis of the Filters:
1. **Filter \( H_1(z) \) (Impulse Invariance)**:
   - After performing the partial fraction decomposition using `residuez`, you can check the poles \( P_1 \) obtained from the decomposition.
   - If all poles \( P_1 \) are within the unit circle (i.e., \( |P_1| < 1 \)), then \( H_1(z) \) is stable. If any pole lies on or outside the unit circle, the filter is unstable.

2. **Filter \( H_2(z) \) (Bilinear Transform)**:
   - Similarly, check the poles \( P_2 \) obtained from the `residuez` function for \( H_2(z) \).
   - The same stability criterion applies: if all poles \( P_2 \) are within the unit circle, then \( H_2(z) \) is stable.

### Comments on Stability:
- **Impulse Invariance Method**: This method can sometimes lead to instability if the analogue filter has poles that are close to the imaginary axis. The transformation to the digital domain may result in poles that lie outside the unit circle.
- **Bilinear Transform Method**: This method is generally more stable than impulse invariance because it maps the entire left half of the s-plane into the unit circle in the z-plane. However, care must be taken with the frequency warping that occurs during the transformation.

### Conclusion:
- After running the code and checking the poles for both filters, you can conclude whether each filter is stable based on the pole locations.
- If both filters are stable, they can be used reliably in applications without the risk of producing unbounded outputs. If either filter is unstable, it may require redesigning or using a different method to ensure stability. 

### Example Code to Check Stability:
You can add the following code snippet after the partial fraction decomposition to check the stability of both filters:

```matlab
% Check stability of H1(z)
is_stable_H1 = all(abs(P1) < 1);
disp(['H1(z) is stable: ', num2str(is_stable_H1)]);

% Check stability of H2(z)
is_stable_H2 = all(abs(P2) < 1);
disp(['H2(z) is stable: ', num2str(is_stable_H2)]);
```

This will output whether each filter is stable based on the pole locations.