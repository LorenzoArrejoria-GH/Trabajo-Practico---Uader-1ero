program ExamenFinalFundamentosProgramacion;

const
  MAX_DEV = 100; 

type
 
  TDesarrollador = record
    nombre: string;
    lenguaje: string;
    pais: string;
    proyectos: integer;
    calificacion: real;
  end;

  TVecDesarrolladores = array[1..MAX_DEV] of TDesarrollador;
  
  
  TMatrizEcommerce = array[1..30, 1..4] of real;


procedure CargarDatos(var vec: TVecDesarrolladores; var n: integer);
var
  respuesta: char;
begin
  n := 0;
  writeln('=== 1.a) CARGA DE DATOS DE DESARROLLADORES ===');
  repeat
    n := n + 1;
    write('Ingrese nombre completo: ');
    readln(vec[n].nombre);
    write('Ingrese lenguaje principal (Python, JavaScript, C#, Go): ');
    readln(vec[n].lenguaje);
    write('Ingrese pais de residencia: ');
    readln(vec[n].pais);
    write('Ingrese cantidad de proyectos finalizados: ');
    readln(vec[n].proyectos);
    write('Ingrese calificacion promedio (1 a 5): ');
    readln(vec[n].calificacion);
    
    write('Desea cargar otro desarrollador? (S/N): ');
    readln(respuesta);
  until (respuesta = 'N') or (respuesta = 'n') or (n >= MAX_DEV);
end;


procedure CalificacionPython(vec: TVecDesarrolladores; n: integer);
var
  i: integer;
  suma: real;
  contador: integer;
begin
  suma := 0;
  contador := 0;
  for i := 1 to n do
  begin
    if vec[i].lenguaje = 'Python' then
    begin
      suma := suma + vec[i].calificacion;
      contador := contador + 1;
    end;
  end;

  writeln;
  writeln('=== 1.b) CALIFICACION PROMEDIO - PYTHON ===');
  if contador > 0 then
    writeln('La calificacion promedio de los desarrolladores de Python es: ', (suma / contador):0:2)
  else
    writeln('No hay desarrolladores registrados con el lenguaje Python.');
end;


procedure ListarOrdenadoPaisNombre(var vec: TVecDesarrolladores; n: integer);
var
  i, j: integer;
  aux: TDesarrollador;
begin
  {ordenamiento burbuja}
  for i := 1 to n - 1 do
  begin
    for j := 1 to n - i do
    begin
      if (vec[j].pais > vec[j+1].pais) or 
         ((vec[j].pais = vec[j+1].pais) and (vec[j].nombre > vec[j+1].nombre)) then
      begin
        aux := vec[j];
        vec[j] := vec[j+1];
        vec[j+1] := aux;
      end;
    end;
  end;

  writeln;
  writeln('=== 1.c) LISTADO ORDENADO POR PAIS Y NOMBRE ===');
  writeln('Pais':15, 'Nombre':20, 'Lenguaje':15, 'Proyectos':12, 'Calificacion':15);
  writeln('--------------------------------------------------------------------------------');
  for i := 1 to n do
  begin
    writeln(vec[i].pais:15, vec[i].nombre:20, vec[i].lenguaje:15, vec[i].proyectos:12, vec[i].calificacion:15:2);
  end;
end;

{busqueda binaria para buscar a Ana Martinez}
procedure BuscarAnaMartinez(vec: TVecDesarrolladores; n: integer);
var
  i, j: integer;
  aux: TDesarrollador;
  primero, ultimo, medio: integer;
  encontrado: boolean;
  vecOrdenado: TVecDesarrolladores;
begin

  for i := 1 to n do
    vecOrdenado[i] := vec[i];

  
  for i := 1 to n - 1 do
  begin
    for j := 1 to n - i do
    begin
      if vecOrdenado[j].nombre > vecOrdenado[j+1].nombre then
      begin
        aux := vecOrdenado[j];
        vecOrdenado[j] := vecOrdenado[j+1];
        vecOrdenado[j+1] := aux;
      end;
    end;
  end;

  primero := 1;
  ultimo := n;
  encontrado := false;

  while (primero <= ultimo) and (not encontrado) do
  begin
    medio := (primero + ultimo) div 2;
    if vecOrdenado[medio].nombre = 'Ana Martínez' then
    begin
      encontrado := true;
    end
    else
    begin
      if 'Ana Martínez' < vecOrdenado[medio].nombre then
        ultimo := medio - 1
      else
        primero := medio + 1;
    end;
  end;

  writeln;
  writeln('=== 1.d) BUSQUEDA BINARIA (Ana Martinez) ===');
  if encontrado then
  begin
    writeln('¡Ana Martínez se encuentra registrada!');
    writeln('Lenguaje principal: ', vecOrdenado[medio].lenguaje);
    writeln('Pais de residencia: ', vecOrdenado[medio].pais);
  end
  else
  begin
    writeln('La desarrolladora Ana Martínez no se encuentra registrada.');
  end;
end;


procedure MayorProyectos(vec: TVecDesarrolladores; n: integer);
var
  i: integer;
  maxProyectos: integer;
  hayEmpate: boolean;
begin
  if n > 0 then
  begin
    maxProyectos := vec[1].proyectos;
    hayEmpate := false;

    for i := 2 to n do
    begin
      if vec[i].proyectos > maxProyectos then
      begin
        maxProyectos := vec[i].proyectos;
        hayEmpate := false;
      end
      else if vec[i].proyectos = maxProyectos then
      begin
        hayEmpate := true;
      end;
    end;

    writeln;
    writeln('=== 1.e) MAYOR CANTIDAD DE PROYECTOS Y EMPATE ===');
    writeln('La mayor cantidad de proyectos finalizados es: ', maxProyectos);
    if hayEmpate then
      writeln('¡Atención! Hubo un empate entre desarrolladores con la misma cantidad máxima de proyectos.')
    else
      writeln('No hubo empate en el primer puesto.');
  end;
end;

{EJERCICIO 2 (Matriz)}
procedure ProcesarEcommerce(matriz: TMatrizEcommerce);
var
  i: integer;
  contadorGastoAlto: integer;
  porcentaje: real;
  filaMax: integer;
  maxComprasMes: real;
begin
  { a) Porcentaje de clientes con promedio de gasto por compra > $10.000 (Columna 4) }
  contadorGastoAlto := 0;
  for i := 1 to 30 do
  begin
    if matriz[i, 4] > 10000 then
      contadorGastoAlto := contadorGastoAlto + 1;
  end;

  porcentaje := (contadorGastoAlto * 100) / 30;

  writeln;
  writeln('=== EJERCICIO 2: E-COMMERCE ===');
  writeln('2.a) Porcentaje de clientes con promedio de gasto > $10.000: ', porcentaje:0:2, '%');

  { b) Informar el cliente que más compró en el último mes (Columna 2) }
  filaMax := 1;
  maxComprasMes := matriz[1, 2];

  for i := 2 to 30 do
  begin
    if matriz[i, 2] > maxComprasMes then
    begin
      maxComprasMes := matriz[i, 2];
      filaMax := i;
    end;
  end;

  writeln('2.b) El cliente que más compró en el último mes se encuentra en la Fila: ', filaMax);
  writeln('     Cantidad de compras realizadas: ', maxComprasMes:0:0);
  writeln('     Valor total gastado en el último mes: $', matriz[filaMax, 3]:0:2);
end;


{PROGRAMA PRINCIPAL}

var
  vectorDevs: TVecDesarrolladores;
  nDevs: integer;
  matrizComercio: TMatrizEcommerce;
  r, c: integer;
begin
  {Ejecucion del ejercicio 1}
  CargarDatos(vectorDevs, nDevs);
  
  if nDevs > 0 then
  begin
    CalificacionPython(vectorDevs, nDevs);
    ListarOrdenadoPaisNombre(vectorDevs, nDevs);
    BuscarAnaMartinez(vectorDevs, nDevs);
    MayorProyectos(vectorDevs, nDevs);
  end;

  {Inicializacion de la matriz del ejercicio 2}
  for r := 1 to 30 do
    for c := 1 to 4 do
      matrizComercio[r, c] := 0;

  {Ejercicio 2 }
  matrizComercio[15, 2] := 18;      
  matrizComercio[15, 3] := 250000;  
  matrizComercio[15, 4] := 13888.88;

  ProcesarEcommerce(matrizComercio);

  writeln;
  writeln('Fin del programa. Presione Enter para salir...');
  readln;
  readln;
end.