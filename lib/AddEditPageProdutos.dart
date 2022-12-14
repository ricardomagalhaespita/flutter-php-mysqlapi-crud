import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'produtos.dart';

class AddEditPageProdutos extends StatefulWidget {
  final List list;
  final int index;
  AddEditPageProdutos({this.list,this.index});
  @override
  _AddEditPageProdutosState createState() => _AddEditPageProdutosState();
}

class _AddEditPageProdutosState extends State<AddEditPageProdutos> {

  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();


  bool editMode = false;


  addUpdateData(){
    if(editMode){
      var url = 'http://localhost/trabflutter/Produtos/edit.php';
      http.post(Uri.parse(url),body: {
        'id' : widget.list[widget.index]['id'],
        'descricao' : descricao.text,
        'valor' : valor.text,

      });
    }else{
      var url = 'http://localhost/trabflutter/Produtos/add.php';
      http.post(Uri.parse(url),body: {
        'descricao' : descricao.text,
        'valor' : valor.text,
      });
    }

  }


  @override
  void initState() {
    super.initState();
    if(widget.index != null){
      editMode = true;
      descricao.text = widget.list[widget.index]['descricao'];
      valor.text = widget.list[widget.index]['valor'];
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 35, 35),
        centerTitle: true,
        title: Text(editMode ? 'Atualizar' :'Adicionar'),),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descricao,
              decoration: InputDecoration(
                icon: Icon(Icons.shopping_bag_rounded),
                labelText: 'Descrição do Produto',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: valor,
              decoration: InputDecoration(
                icon: Icon(Icons.attach_money_sharp),
                labelText: 'Valor do Produto',
              ),
            ),
          ),

          Padding(padding: EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.black),
           
              onPressed: (){
                setState(() {
                  addUpdateData();
                }
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosPage(),),);
                debugPrint('O "ElevatedButton" foi apertado!');
              },
             // color: Colors.blue,
              child: Text(editMode ? 'Atualizar' :'Salvar',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
