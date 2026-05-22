# Backup Automático: VM para PC Local

Script em PowerShell que monitora uma pasta na VM e copia os arquivos modificados para o PC local em segundo plano.

---

## Como Configurar

### Passo 1: Editar as Pastas no Script
Abra o arquivo `watch-and-copy.ps1` e mude os caminhos da origem e do destino:

```powershell
$global:pastaOrigem  = "C:\caminho\da\pasta\na\vm"
$global:pastaDestino = "\\tsclient\C\caminho\da\pasta\no\pc\local" # NÃO APAGUE O "\\tsclient\"
```

### Passo 2: Liberar o Acesso ao PC Local (RDP)
1. Abra a **Conexão de Área de Trabalho Remota** no seu PC.
2. Clique em **Mostrar opções** > aba **Recursos locais**.
3. Clique em **Mais...** dentro de *Dispositivos e recursos locais*.
4. Marque a caixa **Unidades** (especialmente o **C:**).
5. Clique em **OK** e conecte na VM.
6. Copie o script editado para dentro da VM.

### Passo 3: Agendar para Rodar em Segundo Plano
1. Na VM, abra o **Task Scheduler** (Agendador de Tarefas).
2. Clique em **Create Task...** (Criar Tarefa).
3. Na aba **General**: dê um nome para a tarefa.
4. Na aba **Triggers**: clique em *New...* e mude o topo para **At log on**. Clique em *OK*.
5. Na aba **Actions**: clique em *New...*, mantenha *Start a program* e preencha:
   * **Program/script:** `powershell.exe`
   * **Add arguments:** `-WindowStyle Hidden -File "C:\caminho\seu-script.ps1"`
6. Clique em **OK** para salvar.

---

## ⚠️ Como Ativar

O script só começa a funcionar após você **deslogar** e **logar novamente** na VM.

* **Certo:** Fazer *Sign out* / *Log off* da VM e conectar de novo.
* **Errado:** Apenas fechar a janela da VM no "X". Se apenas fechar, o backup não vai iniciar.

```
