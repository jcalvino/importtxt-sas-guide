/*** using server unix for get the file

%let dir=/home/entrada/;

/*** using prodction libery
%let lib=PROD;

/*** create table
%macro CriaTab(anomes); 

  /*** table name
  data &lib..pessoa_&anomes.
  
   ( label = "Registro pessoa" )
	
   format Codigo        $1.
          id            $1.  
          Nome          $100.
  	      Area          $25.
          data_carga    $10.
       ;
   
   label
       Codigo        = "Codigo usuario"
       id            = "id usuario"
       Nome          = "Nome usuario"
       Area          = "area do usuario"
       data_carga    = "Data da carga"
;    

  /*** file location with delimiter ';' and excluding the first line
    infile "&dir.pessoa_.&anomes..txt" dlm=";"  firstobs=2;
	
    input
       Codigo       :$1.
       id           :$1.
       Nome         :$100.
       Area         :$25.
       data_carga   :$10.
	   
	
  /*** create other table
  &lib..Salario_&anomes.
  
   ( label = "Salario pessoa" )
	
   format id            1.  
          salario       Commax15.6
       ;
   
   label
       id            = "id pessoa"
       salario       = "Salario pessoa"
;    
  
    /*** file location with delimiter ';' and excluding the first line
    infile "&dir.salario_.&anomes..txt" dlm=";" dsd  firstobs=2;
	
    input
       id           :1.
       salario      :$15.
run;
%mend;

/*** start the marcro
%CriaTab(201801);
%CriaTab(201802);
%CriaTab(201803);
