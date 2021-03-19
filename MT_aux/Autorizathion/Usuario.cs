using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace MT_aux
{
    public enum TrocarSenhaResultado { Sucesso, SenhaAtualInvalida, NovaSenhaVazia, NovaSenhaNaoConfere, ErroAoTrocar }

    public enum UserPermissoes
    {
        [Description("Altera dados sem Restrições")]
        semRestricao = 'S',

        [Description("Somente atos do dia, exceto Assentamentos Acessórios e Variáveis adicionais")]
        apenasAssentVari = '0',

        [Description("Somente atos do dia")]
        somentedia = '1',

        [Description("Somente atos do dia, exceto Inteiro teor")]
        apenasInteiroTeor = '2',

        [Description("Somente atos do dia, exceto Assentamentos Acessórios, Variáveis adicionais e Inteiro Teor")]
        apenasAssentVariInteiroTeor = '3'
    }

    public enum TipoLogin
    {
        indefinido = 0,

        [Description("Login e Senha")]
        LoginSenha = 1,

        [Description("Certificado Digital")]
        Certificado = 2,

        [Description("Biometria")]
        Biometria = 4,

        [Description("Certificado ou Login e Senha")]
        LoginSenhaCertificado = 3,

        [Description("Biometria ou Login e Senha")]
        LoginSenhaBiometria = 5,

        [Description("Certificado Digital ou Biometria")]
        CertificadoBiometria = 6,

        [Description("Certificado Digital ou Biometria ou Login e Senha")]
        LoginSenhaCertificadoBiometria = 7
    }

    [Serializable]
    public class Usuario
    {
        public int UserID { get; set; }
        public string Login { get; set; }

        public string Nome { get; set; } = "";
        public string Funcao { get; set; }
        public string Documento { get; set; }
        public string TipoDocumento { get; set; }
        public string CPF { get; set; }
        public string Modulos { get; set; }
        public string Observacoes { get; set; }

        public string NomeFuncao
        {
            get
            {
                return Nome + $" ({Funcao})";
            }
        }

        /// <summary>
        /// Propriedade indica se o usuário pode incluir imagem em registros antigos
        /// </summary>
        ///
        public bool IncluiImagem { get { return _IncluiImagem.ToString().ToUpper() == "S"; } }

        public char _IncluiImagem { get; set; }

        public DateTime? DataCriacao { get; private set; }

        public bool IsSupervisor { get; set; }

        public bool IsSuporte => Login?.ToLower()?.Equals("suporte") ?? false;

        public bool Ativo { get; private set; }

        public Usuario()
        {
            //Permissoes = new Acessos();
            Login = "";
            UserID = -1;
        }
    }

    public class Acesso
    {
        public int ID { get; set; }
        public string PROG { get; }
        public string PERM { get; set; }

        public Acesso(string prog, string perm)
        {
            PROG = prog;
            PERM = perm;
        }
        public bool CanAccess()
        {
            if (PERM.Length == 5)
                return PERM[0] == '1';
            return false;
        }

        public bool CanInclude()
        {
            if (PERM.Length == 5)
                return PERM[1] == '1';
            return false;
        }

        public bool CanChange()
        {
            if (PERM.Length == 5)
                return PERM[2] == '1';
            return false;
        }

        public bool CanExclude()
        {
            if (PERM.Length == 5)
                return PERM[3] == '1';
            return false;
        }

        public bool CanPrint()
        {
            if (PERM.Length == 5)
                return PERM[4] == '1';
            return false;
        }
    }

    [Serializable]
    public class Acessos
    {
        private Usuario User;

        public void SetUser(Usuario user)
        {
            User = user;
        }
        public List<Acesso> ListaAcessos { get; set; }
        public Acessos(Usuario user)
        {
            ListaAcessos = new List<Acesso>();
            // Nascimento = new NascimentoPermissoes(this);
            User = user;
        }

        public void Add(string PROG, string PERM)
        {
            ListaAcessos.Add(new Acesso(PROG, PERM));
        }

        public bool CanAccess(string PROG)
        {
            if (User?.IsSupervisor ?? false)
                return true;

            var acesso = ListaAcessos.FirstOrDefault(n => n.PROG == PROG);
            return acesso != null && acesso.CanAccess();
        }

        public bool CanInclude(string PROG)
        {
            if (User?.IsSupervisor ?? false)
                return true;

            var acesso = ListaAcessos.FirstOrDefault(n => n.PROG == PROG);
            return acesso != null && acesso.CanInclude();
        }

        public bool CanChange(string PROG)
        {
            if (User?.IsSupervisor ?? false)
                return true;

            var acesso = ListaAcessos.FirstOrDefault(n => n.PROG == PROG);
            return acesso != null && acesso.CanChange();
        }

        public bool CanExclude(string PROG)
        {
            if (User?.IsSupervisor ?? false)
                return true;

            var acesso = ListaAcessos.FirstOrDefault(n => n.PROG == PROG);
            return acesso != null && acesso.CanExclude();
        }

        public bool CanPrint(string PROG)
        {
            if (User?.IsSupervisor ?? false)
                return true;

            var acesso = ListaAcessos.FirstOrDefault(n => n.PROG == PROG);
            return acesso != null && acesso.CanPrint();
        }
    }
}
