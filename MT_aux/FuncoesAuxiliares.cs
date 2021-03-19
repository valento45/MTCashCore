using System;
using System.Collections.Generic;
using System.Text;

namespace MT_aux
{
    public static class FuncoesAuxiliares
    {
        public static string FormataTelefone(string telSemPontuacao)
        {            
            if (telSemPontuacao == string.Empty)
                return "";
            foreach (var x in telSemPontuacao)
                if (!char.IsNumber(x))
                    telSemPontuacao = telSemPontuacao.Replace(x, ' ').Trim();
            if (telSemPontuacao.Length == 0)
                return "";
            else if (telSemPontuacao.Length == 8)
                return string.Format("{0:0000-0000}", telSemPontuacao);
            else if (telSemPontuacao.Length == 9)
                return string.Format("{0:00000-0000}", telSemPontuacao);
            else if (telSemPontuacao.Length == 10)
                return string.Format("{0:(00)0000-0000}", telSemPontuacao);
            else if (telSemPontuacao.Length == 11)
                return string.Format("{0:(00)00000-0000}", telSemPontuacao);
            else
                return telSemPontuacao;
        }
       
    }
}
