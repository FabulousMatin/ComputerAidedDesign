# CAD Projects
- [CA1: MaxNet](#ca1-maxnet)
- [CA2: MaxNet re-design Using Actel Modules](#ca2-maxnet-re-design-using-actel-modules)
- [Midterm: Convultion](#midterm-convultion)
- [CA3: One Layer CNN](#ca3-one-layer-cnn)
- [CA3-P2: Two Layer CNN](#ca3-p2-two-layer-cnn)

## CA1: MaxNet
A simple layer which output the maximum input. This is done with multiple epochs and subtracting small value(called epsilon) from inputs.

docs and digrams are placed in `./CA1/doc`

to run, open project and then:
```text
do sim_tp.tcl
```

## CA2: MaxNet re-design Using Actel Modules
The maxnet is re-designed using Actel Act-modules. to wee details read `./CA2/report.pdf`
The controller is designed using a synthesize extension called `digitaljs`.

docs and digrams are placed in `./CA2/doc`

to run, open project and then:
```text
do sim_tp.tcl
```

## Midterm: Convultion 
A convolution calculater which inputs a 16 × 16 input and a 4 × 4 filter and ouput convulted 13 × 13 output. There is an aided 8 × 8 buffer available.

A test generator is written in python and create a random input/output.
There are some changes in calculations and bit shiftings.

docs and digrams are placed in `./Midterm/doc`

to run, open project and then:
```text
do sim_tp.tcl
```

## CA3: One Layer CNN
A one layer convultional which input an input, a `nkernel` which defines number of kernels(or neurons), and `nkernel` kernels.

docs and digrams are placed in `./CA3/doc`

to run, open project and then:
```text
do sim_tp.tcl
```
## CA3-P2: Two Layer CNN
Same as `CA3` but now the output of layer one is the input of layer two so we have a 2-layer CNN.

docs and digrams are placed in `./CA3-P2/doc`

to run, open project and then:
```text
do sim_tp.tcl
```