---
marp: true
theme: default
header: 'LCI Intermediate - Apptainer'
footer: 'May 12th 2024'
paginate: true
style: |
  .skip-header-footer header,
  .skip-header-footer footer {
    display: none;
  }
---
<!-- _paginate: skip -->

# <!--fit--> LCI Intermediate - Apptainer
Alan Chapman
Systems Analyst - Software Specialist
RTO Research Computing
Arizona State University 

---

### The Journey of Containerization
- **Early Beginnings:** The concept of containerization in computing can be traced back to chroot in 1979, which changed the root directory for a running process and its children to a new location in the filesystem, isolating it. This was the foundational idea behind containerization.
- **Technology Milestones:** FreeBSD Jails introduced in 2000 allowed administrators to partition a FreeBSD computer system into several independent mini-systems. Linux VServer and Solaris Zones followed, offering similar partitioning capabilities for Linux and Solaris systems, respectively. Docker, introduced in 2013, significantly simplified and popularized container technology, leading to widespread adoption and the development of container orchestration systems like Kubernetes.
- **Orchestration Evolution:** Kubernetes emerged as a critical tool for managing large-scale container deployments, automating deployment, scaling, and management of containerized applications.

---

### Building a TensorFlow Container with Apptainer

#### 1. Prepare the Definition File
The first step is to create an Apptainer definition file, which specifies the environment and instructions for building the container. Here’s a simplified example:

---

```shell
Bootstrap: docker
From: tensorflow/tensorflow:latest-gpu

%post
    # Update and install necessary packages
    apt-get update && apt-get install -y git wget
    # (Optional) Additional steps for custom software installation

%environment
    export LOG_DIR=/var/logs/tensorflow

%runscript
    # Default command to run when the container is executed
    exec tensorflow

%help
    This container includes TensorFlow with GPU support.
```
---

This definition file starts from a base TensorFlow image with GPU support from Docker Hub, installs additional packages, and sets up an environment variable and a default run command.

---

#### 2. Build the Container
With the definition file ready, the next step is to build the container. This process requires root access or administrative privileges.

```shell
sudo apptainer build tensorflow.sif tensorflow.def
```

This command tells Apptainer to build a container named `tensorflow.sif` based on the instructions in `tensorflow.def`.

---

### Using the TensorFlow Container on an HPC System

#### 1. Transfer the Container
Once built, transfer the `.sif` file to the HPC system using `scp` or any other secure file transfer method.

#### 2. Load Necessary Modules
Before running the container, load any necessary modules on the HPC system, especially those related to GPU drivers or MPI, if your TensorFlow application requires them.

```shell
module load cuda/10.1
```

---

#### 3. Execute the Container
Run the TensorFlow container using Apptainer, specifying any required arguments or commands. For example, to start a Python script that uses TensorFlow:

```shell
apptainer exec --nv tensorflow.sif python my_tensorflow_script.py
```

The `--nv` flag enables NVIDIA GPU support within the container, crucial for TensorFlow operations that are GPU-accelerated.

---

### Advantages for HPC Use
Using Apptainer to containerize TensorFlow and run it on an HPC system offers several advantages:

- **Consistency**: Ensures that TensorFlow runs in a consistent environment across different machines and users.
- **Portability**: Makes it easy to share the TensorFlow environment with collaborators or deploy it across various systems.
- **Performance**: Allows TensorFlow to leverage the underlying HPC infrastructure, including GPUs, for high-performance computations.
- **Simplicity**: Simplifies complex software dependency management, making it easier to maintain and update the TensorFlow environment.

---

Incorporating TensorFlow as an example in the presentation illustrates not only the versatility of Apptainer in managing and deploying containers in HPC environments but also highlights its practical application in supporting cutting-edge machine learning workloads.

---

from settings.json
```json
{
    "markdown.marp.themes": [        
        "./themes/academic.scss",
        "./themes/nord-theme.scss",
        "./themes/wave.scss",
        "https://raw.githubusercontent.com/mastern2k3/marpit-nord-theme/master/build/nord-theme.css",
        "https://raw.githubusercontent.com/JuliusWiedemann/MarpThemeWave/main/source/wave.css",
        "https://cunhapaulo.github.io/style/freud.css"
    ]
}

```
---