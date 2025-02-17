<?php
    include_once 'classes\pessoa.php';
    
    if (!empty($_GET['ID_PESSOA']))
    {
        $id = $_GET['ID_PESSOA'];

        $P = new Pessoa;
        $linhas = $P->PessoaExiste($ID_PESSOA, $erro);
        if ($erro != '')
        {
            if ($erro != "")
                echo 'Falhou ! <br/> Motivo:<br/>'.$erro;
            else
                echo 'Registro não encontrado.<br/>';
        }
        else
        {
            $linhas = $P->PessoaGet($ID_PESSOA, $erro);
            foreach ($linhas as $lin)
            {
                $CPF     = $lin['CPF'];
                $NOME    = $lin['NOME'];
                $FONE    = $lin['FONE'];
                $EHWHATS = $lin['EHWHATS'];
                $SENHA   = $lin['SENHA'];
                $EMAIL   = $lin['EMAIL'];
                $ATIVO   = $lin['ATIVO'];
                $EHOFICIAL = $lin['EHOFICIAL'];
                $LIB_CADDESASTRE = $lin['LIB_CADDESASTRE'];
                $REGISTRO_OFICIAL = $lin['REGISTRO_OFICIAL'];
                $CONTATOS = $lin['CONTATOS'];
                $END_LOG = $lin['END_LOG'];
                $END_NUM = $lin['END_NUM'];
                $END_BAI = $lin['END_BAI'];
                $END_CID = $lin['END_CID'];
                $END_CEP = $lin['END_CEP'];
                $END_COM = $lin['END_COM'];
                $END_UF  = $lin['END_UF'];
            }
        }
    }

    if (isset($_POST['gravar']))
    {

        $CPF     = $_POST['cpf'];
        $NOME    = $_POST['nome'];
        $FONE    = $_POST['fone'];
        $EHWHATS = $_POST['what'];
        if (empty($EHWHATS)) {
            $EHWHATS = 'N';
        }
        $SENHA   =$_POST['password'];
        $EMAIL   =$_POST['email'];
        $ATIVO   = 'S';
        $EHOFICIAL = $_POST['oficialck'];
        if (empty($EHOFICIAL)) {
            $EHOFICIAL = 'N';
        }
        $LIB_CADDESASTRE =$_POST['fone'];
        $REGISTRO_OFICIAL =$_POST['oficial'];
        $CONTATOS =$_POST['contatos'];
        $END_LOG =$_POST['logradouro'];
        $END_NUM =$_POST['n'];
        $END_BAI =$_POST['bairro'];
        $END_CID =$_POST['cidade'];
        $END_CEP =$_POST['cep'];
        $END_COM =$_POST['complemento'];
        $END_UF  =$_POST['uf'];

        $P = new Pessoa;
        if ($P->PessoaUPD($CPF,
                        $NOME,
                        $FONE,
                        $EHWHATS,
                        $SENHA,
                        $EMAIL,
                        $ATIVO,
                        $EHOFICIAL,
                        $LIB_CADDESASTRE,
                        $REGISTRO_OFICIAL,
                        $CONTATOS,
                        $END_LOG,
                        $END_NUM,
                        $END_BAI,
                        $END_CID,
                        $END_CEP,
                        $END_COM,
                        $END_UF, $erro) > 0)
        {
            //echo 'Alterado com sucesso !';
            header("location: index.php");
            //exit;
        }
        else
            echo 'Falhou ! <br/> Motivo:<br/>'.$erro;

        unset($P); 
    }
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Alterando Cadastro</title>
</head>
<body>
    <div class="container">
        <div class="logo">
           <h1><img src="imagens/logo.png" alt="">SADN
           </h1>
           <p>Sistema de Apoio a Desastre Natural</p>
        </div>
        <div class="form-image">
            <img src="imagens/Global warming-rafiki.svg" alt="">
        </div>
        <div class="form">
            <form action="cadastropessoas_add.php" method="POST">
                <div class="form-header">
                    <div class="title">
                        <h1>Cadastra-se</h1>
                    </div>
                </div>
                <div class="input-group">
                    <div class="input-box" >
                        <label for="nome">Nome Completo</label>
                        <input id="nome" type="text" name="nome"  placeholder="Digite seu nome Completo" value="<?php echo $NOME ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="cpf">CPF</label>
                        <input id="cpf" type="text" name="cpf"  placeholder="xxx.xxx.xxx-xx" value="<?php echo $CPF ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="fone">Celular</label>
                        <input id="fone" type="tel" name="fone" placeholder="(xx) xxxxx-xxxx" value="<?php echo $FONE ?>" required>
                        <label for="what">Tem WhatsApp.</label>
                        <input type="checkbox" id="what" name="what" value="S" checked>
                    </div>
                    <div class="input-box">
                        <label for="logradouro">Logradouro</label>
                        <input id="logradouro" type="text" name="logradouro"   placeholder="Digite o seu logradouro" value="<?php echo $END_LOG ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="n">Nº</label>
                        <input id="n" type="text" name="n"  placeholder="Digite o número da sua recidência" value="<?php echo $END_NUM ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="bairro">Bairro</label>
                        <input id="bairro" type="text" name="bairro"  placeholder="Digite seu bairro" value="<?php echo $END_BAI ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="cidade">Cidade</label>
                        <input id="cidade" type="text" name="cidade"  placeholder="Digite sua cidade" value="<?php echo $END_CID ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="uf">UF</label>
                        <input id="uf" type="text" name="uf"  placeholder="Digite seu estado" value="<?php echo $END_CID ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="cep">CEP</label>
                        <input id="cep" type="text" name="cep"  placeholder="xx.xxx-xxx" value="<?php echo $END_CEP ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="complemento">Complemento</label>
                        <input id="complemento" type="text" name="complemento" value="<?php echo $END_COM ?>">
                    </div>
                    <div class="input-box">
                        <label for="email">E-mail</label>
                        <input id="email" type="email" name="email"  placeholder="Digite o e-mail" value="<?php echo $EMAIL ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="password">Senha</label>
                        <input id="password" type="password" name="password"  placeholder="Digite a senha" value="<?php echo $SENHA ?>" required>
                    </div>
                    <div class="input-box">
                        <label for="confirmpassword">Confirme a senha</label>
                        <input id="confirmpassword" type="password" name="comfirmpassword" placeholder="Digite a senha" >
                    </div>
                    <div class="input-box">
                        <label for="oficial">Número de registro</label>
                        <input id="oficial" type="text" name="oficial"  placeholder="Digite o número do seu registro oficial" value="<?php echo $REGISTRO_OFICIAL ?>">
                        <label for="oficial">Eu sou oficial.</label>
                        <input type="checkbox" id="oficialck" name="oficialck" value="S" checked>
                    </div>
                    <div class="input-box">
                        <label for="contatos">Contatos</label>
                        <textarea id="contatos" type="text" name="contatos" placeholder="Contatos dos Familiares" value="<?php echo $CONTATOS ?>"></textarea>
                    </div>
                    <div class="continue-button ">
                       <button type="submit" name="gravar" id="gravar">Cadastrar</button>
                       <button type="submit"><a href="index.php">Voltar</a></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
