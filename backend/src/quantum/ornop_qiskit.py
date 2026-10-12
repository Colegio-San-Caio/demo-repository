# ORNOP // Qiskit + size_t logic - DCNC CODE UNISCI - EMU MODE
try:
    from qiskit import QuantumCircuit
    from qiskit_aer import AerSimulator
    HAS_QISKIT=True
except:
    HAS_QISKIT=False
    print("Qiskit non installatu - emu size_t mode")

class ORNOP_Qiskit_SizeT:
    def __init__(self, num_qubits: int):  # size_t
        if num_qubits <= 0:
            raise ValueError("size_t must be > 0")
        self.size = num_qubits
        if HAS_QISKIT:
            self.qc = QuantumCircuit(num_qubits)

    def build_mishua_circuit(self):
        if not HAS_QISKIT:
            return f"MISHUA v24H2 circuit size_t={self.size} qubits (emu)"
        for i in range(self.size):
            self.qc.h(i)
        self.qc.measure_all()
        return self.qc

    def run(self):
        if not HAS_QISKIT:
            return {f"{'0'*self.size}": 512, f"{'1'*self.size}": 512}
        from qiskit_aer import AerSimulator
        sim = AerSimulator()
        return sim.run(self.qc, shots=1024).result().get_counts()

# Test size_t = 3
q = ORNOP_Qiskit_SizeT(3)
print(f"size_t = {q.size}")
print(q.build_mishua_circuit())
print(q.run())
print("Iè Corsu Approvatu - ORNOP Quantum UNISCI")
