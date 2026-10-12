# ORNOP // Qiskit + size_t logic - DCNC CODE UNISCI
from qiskit import QuantumCircuit
from qiskit_aer import AerSimulator

class ORNOP_Qiskit_SizeT:
    def __init__(self, num_qubits: int):  # size_t in C++ = int >0 in python
        if num_qubits <= 0:
            raise ValueError("size_t must be > 0")
        self.size = num_qubits  # size_t
        self.qc = QuantumCircuit(num_qubits)

    def build_mishua_circuit(self):
        # MISHUA v24H2 UNISCI circuit
        for i in range(self.size):
            self.qc.h(i)
        self.qc.measure_all()
        return self.qc

    def run(self):
        sim = AerSimulator()
        return sim.run(self.qc, shots=1024).result().get_counts()

# Test
# q = ORNOP_Qiskit_SizeT(3) # size_t = 3 qubits
# print(q.run())
