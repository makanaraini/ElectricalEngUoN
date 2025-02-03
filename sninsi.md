\section{Lecture 17: 18/11/2024}

\subsection{Introduction}
In the previous class, we derived the input-output relationship of the Gilbert's multiplier cell using an accurate analysis. The result obtained is:
\[
V_{out} = -R_L I \tanh\left(\frac{V_2}{2V_T}\right) \tanh\left(\frac{V_1}{2V_T}\right)
\]
This equation accounts for various values of transconductance \( G_M \) and bias currents \( I_B1 \) and \( I_B2 \). Therefore, Equation (25) represents the input-output relationship of a Gilbert's multiplier cell.

\subsection{Applications of Equation (25)}
Equation (25) has three practical applications, categorized based on the magnitude of \( V_1 \). Recall that \( V_T \) is only 26 mV.

\subsubsection{Case 1: \( \frac{V_1}{2V_T} < 1 \) and \( \frac{V_2}{2V_T} < 1 \)}
In this scenario, we can interchange the hyperbolic tangent functions:
\[
\tanh\left(\frac{V_1}{2V_T}\right) \tanh\left(\frac{V_2}{2V_T}\right) = \tanh\left(\frac{V_2}{2V_T}\right) \tanh\left(\frac{V_1}{2V_T}\right)
\]
Given that \( \frac{V_1}{V_T} < 50 \) mV, this condition is not very useful for practical multipliers, such as those used in communication receivers and transceivers, where higher voltages like 5V or 10V are common.

\subsubsection{Case 2: \( V_1 \) and \( V_2 \) Greater Than \( V_T \)}
When both \( V_1 \) and \( V_2 \) are significantly greater than \( V_T \), the output is given by Equation (25) without simplification. To ensure the multiplier's output remains a product of \( V_1 \) and \( V_2 \), two schemes can be employed:
\begin{enumerate}
    \item Use limited generation resistance in the lower differential amplifier to increase its linear output.
    \item Introduce a nonlinearity that pre-distorts the signals \( V_1 \) and \( V_2 \) to compensate for the hyperbolic tangent transfer function.
\end{enumerate}

\subsection{Pre-Distortion Circuit}
In most practical multipliers, the second scheme is commonly used. We introduce a pre-distortion circuit to compensate for the hyperbolic tangent transfer function. The pre-distortion circuit involves:
\begin{itemize}
    \item Applying a hyperbolic inverse tangent function to \( V_1 \), resulting in \( V'_1 \), which is then applied to the top differential amplifiers.
    \item Applying another hyperbolic inverse tangent function to \( V_2 \), resulting in \( V'_2 \), which is directly applied to the bottom transistors (\( Q_5 \) and \( Q_6 \)).
\end{itemize}
This configuration is widely adopted by IC manufacturers and is known as a pre-distortion or preconditioning circuit. Below is the analysis of such a circuit to demonstrate that it produces a hyperbolic inverse transfer function, allowing it to be connected to the standard Gilbert cell and achieving the complete transfer function of the Gilbert multiplier.

\subsection{Analysis of the Pre-Distortion Circuit}
To extend the dynamic range of the signals \( V_1 \) and \( V_2 \) to \( \pm10 \) volts, we implement the following preconditioning circuit:
\begin{figure}[h]
    \centering
    \includegraphics[width=0.8\linewidth]{preconditioning_circuit.png}
    \caption{Preconditioning Circuit}
    \label{fig:preconditioning}
\end{figure}
This circuit consists of a normal differential amplifier with two transistors as loads. By connecting the collector to the base, the circuit simplifies to a diode-connected transistor, as shown in Figure \ref{fig:preconditioning}. 

\subsubsection{Deriving the Transfer Function}
The first step is to derive the current-to-voltage relationships for the differential amplifier connected in this manner. Let \( R_E \) be the emitter resistance.

Applying Kirchhoff's Voltage Law (KVL) to the input loop of transistors \( Q_1 \) and \( Q_2 \), we obtain:
\[
V_1 = I_1 R_E - I_2 R_E
\]
\[
I_1 + I_2 = I_{total}
\]
Solving these simultaneous equations, we find:
\[
I_1 = \frac{I_{total}}{2} + \frac{V_1}{2R_E}
\]
\[
I_2 = \frac{I_{total}}{2} - \frac{V_1}{2R_E}
\]

The output voltage \( V_{out} \) is given by:
\[
V_{out} = V_{CC} - V_{D1} - V_{D2} = V_D2 - V_D1
\]
Using the diode current equations:
\[
I_{D1} = I_{S1} e^{\frac{V_{D1}}{V_T}}, \quad I_{D2} = I_{S2} e^{\frac{V_{D2}}{V_T}}
\]
Assuming \( I_{S1} = I_{S2} \), we have:
\[
\tanh^{-1}\left(\frac{V_{out}}{2V_T}\right) = \frac{V_{out}}{2V_T}
\]
Thus, the transfer function becomes approximately:
\[
V_{out} \approx 2V_T \tanh^{-1}\left(\frac{K V_1}{I_{total}}\right)
\]
where \( K = \frac{1}{2R_E} \).

\subsection{Overall Response of the Gilbert Multiplier with Preconditioning}
By applying the pre-distortion circuits to both \( V_1 \) and \( V_2 \), the Gilbert multiplier cell can now handle a much larger dynamic range for \( V_1 \) and \( V_2 \), allowing inputs up to \( \pm10 \) volts.

\subsection{Applications}
Analog multipliers, such as the Gilbert multiplier, have numerous applications including:
\begin{itemize}
    \item \textbf{Analog Computations}: Used in analog computers for performing multiplication operations.
    \item \textbf{Frequency Translation}: Essential in modulators, demodulators, and product detectors, particularly in FM detection and TV engineering for color signal processing.
    \item \textbf{Modems}: Utilized in modulation and demodulation schemes to conserve frequency spectrum.
    \item \textbf{Analog Division}: Circuits designed to perform division of two voltages.
    \item \textbf{Square Root Calculations}: Analog circuits that compute the square root of an input voltage.
\end{itemize}

\subsection{Practical Circuits: MC1496 Multiplier}
An example of a practical multiplier is the MC1496, a linear four-quadrant multiplier. Important considerations while using this IC include:
\begin{itemize}
    \item Pin configurations for differential amplifiers and preconditioning circuits.
    \item Ensuring proper biasing and stable current sources.
    \item Utilizing external resistors and capacitors for filtering and biasing.
\end{itemize}
\subsubsection{Pin Configuration and Resistors}
For the MC1496:
\begin{itemize}
    \item Pins 2 and 14 are connected to \( V_{CC} \) through 3k resistors.
    \item Pins 5 and 6 are connected with 27k resistors.
    \item External resistors \( R_X \) are connected to pins 10 and 11 for setting gain.
    \item Pin 1 connects to the preconditioning circuit.
\end{itemize}

\subsection{Current Source Analysis}
In the preconditioning circuit, the constant current source voltage is maintained for temperature stability using diode-connected transistors. For example, in a circuit with \( Q_9 \) and \( Q_{10} \):
\[
I = \frac{V - V_{BE}}{R}
\]
Where \( V_{BE} \) is typically 0.6V for low currents. Ensuring identical currents through matched transistors maintains symmetry and stability in the multiplier circuit.

\subsection{Exam Questions and Practical Exercises}
Students are encouraged to analyze the current through the preconditioning circuits and the Gilbert multiplier cell. Practical exercises include:
\begin{itemize}
    \item Calculating the emitter currents in the multiplier and preconditioning transistors.
    \item Designing resistor values for desired current sourcing.
    \item Implementing and testing analog multiplication and division circuits.
\end{itemize}

\subsection{Conclusion}
The Gilbert multiplier cell, enhanced with preconditioning circuits, offers a robust solution for analog multiplication with a wide dynamic range. Its applications span various fields, including communications, signal processing, and analog computing. Understanding the underlying principles and practical implementations is crucial for leveraging its full potential in electronic circuit design.

\subsection{Practical Circuit Implementation}
Refer to the MC1496 datasheet for detailed pin configurations and application circuits. Ensure proper resistor values and biasing to maintain optimal performance. Pay attention to pin connections for differential amplifiers and preconditioning circuits to achieve the desired multiplication characteristics.

\subsection{Questions and Discussion}
Students are encouraged to ask questions regarding the analysis and implementation of the Gilbert multiplier and preconditioning circuits. Practical understanding is essential for exam success and real-world applications.

