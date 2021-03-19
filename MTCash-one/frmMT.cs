using MT_aux;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace MTCash_one
{
    public partial class frmMT : Form
    {
        public frmMT()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string value = txtTelefone.Text.Trim();
            value = FuncoesAuxiliares.FormataTelefone(value);
        }
    }
}
