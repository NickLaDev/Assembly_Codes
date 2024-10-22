
# 💻 Projetos em Assembly 8086 - MASM/TASM

Este repositório contém os códigos desenvolvidos em **Assembly 8086** durante minhas aulas de **Engenharia da Computação** na **PUC-Campinas**. Cada projeto está organizado por aula, contendo o código-fonte e um arquivo **PDF** que explica o que foi solicitado e como o programa funciona.

---

## 📝 Sobre Assembly 8086

**Assembly** é uma linguagem de baixo nível que permite comunicação direta com o hardware do processador, especificamente o **Intel 8086**, utilizado nas arquiteturas x86. A programação em Assembly requer um conhecimento detalhado da arquitetura da CPU, sendo fundamental para entender o funcionamento interno de sistemas computacionais.

### Características:
- **Linguagem de Baixo Nível**: A programação é feita diretamente com registradores e instruções de controle de hardware.
- **Alta Eficiência**: Permite o controle total da CPU e uma manipulação direta da memória, o que resulta em programas rápidos e otimizados.
- **Ferramentas Utilizadas**:
  - **MASM (Microsoft Assembler)** e **TASM (Turbo Assembler)**: Montadores que traduzem o código Assembly para código de máquina.
  - **Emuladores DOS**, como **DOSBox**, para rodar o ambiente DOS em máquinas modernas.

Assembly é usada em cenários onde o controle direto de hardware é essencial, como em drivers de dispositivos, sistemas embarcados e otimização de performance.

---

## 📁 Estrutura do Repositório

Os códigos estão organizados por aula, e cada pasta contém:

- **Arquivo `.asm`**: Contém o código Assembly desenvolvido para o exercício.
- **Arquivo `.pdf`**: Explicação detalhada do exercício e as instruções do que foi solicitado na aula.

### Exemplo de Estrutura:

- **Aula-01**:
  - `programa.asm`: Código da primeira aula.
  - `explicacao.pdf`: Detalhes sobre o exercício, objetivos e requisitos da aula.
  
- **Aula-02**:
  - `programa.asm`: Código da segunda aula.
  - `explicacao.pdf`: Explicação e instruções específicas da segunda aula.
  
- **Aula-03**:
  - `programa.asm`: Código da terceira aula.
  - `explicacao.pdf`: Detalhamento do que foi pedido no exercício.
  
E assim por diante, com cada aula contendo seu código e explicação.

---

## ⚙️ Como Executar os Códigos

Para rodar os programas desenvolvidos em Assembly 8086, você precisará configurar o ambiente adequado com os seguintes requisitos:

### Pré-requisitos:

- **MASM ou TASM**: Montadores necessários para compilar os arquivos `.asm`.
- **Emulador DOS**: Utilizado para executar os códigos Assembly em ambientes modernos. O **DOSBox** é um dos emuladores mais populares.

### Instruções de Execução:

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git

	2.	Navegue até a pasta da aula desejada:

cd Aula-01


	3.	Compile o arquivo .asm com o montador MASM ou TASM:

masm programa.asm

ou

tasm programa.asm


	4.	Execute o arquivo compilado utilizando o emulador DOS ou ambiente compatível. Se estiver utilizando o DOSBox:
	•	Monte o diretório onde o código está salvo.

mount c /caminho/para/pasta

	•	Navegue para o diretório montado e execute o código:

c:
programa.exe



🗂 Referências e Documentação

Durante o desenvolvimento dos projetos, foram utilizadas as seguintes referências:

	•	Documentação MASM
	•	Tutorial sobre TASM
	•	DOSBox para executar aplicativos em DOS

👨‍💻 Colaborador

	•	Nicolas Laredo - Desenvolvedor dos códigos e autor das explicações dos exercícios.
