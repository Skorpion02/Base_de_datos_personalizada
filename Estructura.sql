ALTER SESSION SET "_ORACLE_SCRIPT" = true;

SET SERVEROUTPUT ON

---------------------------------------------------------------
-- 1)   GESTI�N DE USUARIOS Y TABLAS --------------------------
---------------------------------------------------------------

-- 1. Usuario "GESTOR"

CREATE USER gestor IDENTIFIED BY 1234;
/
--Le damos los privilegios para abrir sesi�n.
GRANT CREATE SESSION TO gestor;
/
--Le damos los privilegios para alterar y modificar los campos de las tablas alumnos y asignaturas
GRANT ALTER ON ILERNA_PAC.ALUMNOS_PAC TO GESTOR;
GRANT ALTER ON ILERNA_PAC.ASIGNATURAS_PAC TO GESTOR;
/

--1.1.2 Tablas alteraciones--

	ALTER TABLE ALUMNOS_PAC
	add CIUDAD varchar(30);
	
	ALTER TABLE ASIGNATURAS_PAC
	MODIFY NOMBRE_PROFESOR varchar(50);
	
	ALTER TABLE ASIGNATURAS_PAC
	DROP COLUMN CREDITOS;
	
	ALTER TABLE ASIGNATURAS_PAC
ADD CICLO VARCHAR(3);
/

-- 2. Usuario "DIRECTOR"
--Creamos un rol dir_rol.
CREATE ROLE DIR_ROL;
--Creamos un usuario director con contrase�a.
CREATE USER DIRECTOR IDENTIFIED BY 1234;
/
--Le damos los privilegios para alterar y modificar los campos de las tablas alumnos y asignaturas.
GRANT ALTER ON ILERNA_PAC.ALUMNOS_PAC TO DIR_ROL;
GRANT ALTER ON ILERNA_PAC.ASIGNATURAS_PAC TO DIR_ROL;
/
--Le damos los privilegios para abrir sesi�n.
GRANT CREATE SESSION TO DIR_ROL;

--Asignamos el rol DIR_ROL al usuario DIRECTOR
GRANT DIR_ROL TO director;
/
--Insertamos dentro de la tabla de alumnos y asignaturas los datos definidos y actualizamos.
INSERT INTO ilerna_pac.alumnos_pac (id_alumno) VALUES('ROGOAN');
INSERT INTO ilerna_pac.asignaturas_pac (id_asignatura, nombre_asignatura, nombre_profesor, creditos) VALUES ('DAX_M02B', 'MP2.Bases de datos','Claudi Godia','DAX');
UPDATE ILERNA_PAC.asignaturas_pac  SET CICLO = 'DAW';
/

---------------------------------------------------------------
-- 2)	BLOQUES ANONIMOS -------------------------------------- 
---------------------------------------------------------------

-- 1. TABLA DE MULTIPLICAR

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;
--C�digo que usamos para darle tama�o a nuestro bloque.
 EXECUTE dbms_output.enable (1000000);

--Declaramos las variables de que tipo son para luego ejecutarlas.
 DECLARE
  numero NUMBER:=0;
  resultado NUMBER;
  tabladel NUMBER(2);

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
 BEGIN
 tabladel:= &tabladel;
 --Usamos un bucle para que nos pueda aparecer por pantalla �nicamente lo que pedimos y el m�ximo que pedimos.
  WHILE numero<=11 LOOP
   resultado:= tabladel*numero;
--Imprimimos por pantalla:
   dbms_output.put_line(tabladel||'*'||to_char(numero)||'='||to_char(resultado));
   numero:=numero+1;
--Cerramos el bucle.
  END LOOP;
  --Cerramos nuestro par�metro.
 END;
 /

-- 2. %IRPF SALARIO BRUTO ANUAL

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Declaramos las variables de que tipo son para luego ejecutarlas pero antes la pedimos por pantalla.
 DECLARE

SALARIO_MES CONSTANT NUMBER(10,2):= &SALARIO_MES;
IRPF NUMBER;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

--Usamos un select para seleccionar el salario que necesitamos imprimir por pantalla.
SELECT IRPF_PAC.porcentaje INTO IRPF FROM IRPF_PAC
WHERE SALARIO_MES * 12 BETWEEN IRPF_PAC.VALOR_BAJO AND VALOR_ALTO;
--Llamamos por consola todos aquellos par�metros que necesitamos imprimir por pantalla.
DBMS_OUTPUT.PUT_LINE('Salario mensual: '||SALARIO_MES||'�');
DBMS_OUTPUT.PUT_LINE('Salario anual: '||SALARIO_MES*12||'�');
DBMS_OUTPUT.PUT_LINE('IRPF aplicado: '||IRPF*100||'%');
DBMS_OUTPUT.PUT_LINE('IRPF a pagar: '||SALARIO_MES*12*IRPF||'�');

--Cerramos nuestro par�metro.
END;
/

---------------------------------------------------------------
-- 3)	PROCEDIMIENTOS Y FUNCIONES SIMPLES -------------------- 
---------------------------------------------------------------

-- 1. SUMA IMPARES

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Creamos un procedimiento que pueda sumar todos los impares hasta el n�mero que elegimos por pantalla
-- y luego declaramos nuestras variables que usaremos m�s adelante.
CREATE OR REPLACE PROCEDURE SUMA_IMPARES(num_entero IN NUMBER)
IS
    i NUMBER:=0;
    n NUMBER:=0;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN 
    
 --Usamos un bucle para que nos pueda aparecer por pantalla �nicamente lo que pedimos y el m�ximo que pedimos por pantalla.

    WHILE (i < num_entero) LOOP
        i:=i+1;
        IF (MOD(i,2)!=0) THEN 
            n:=n+i;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('El resultado de sumar los impares hasta ' ||  num_entero || ' es: ' || n);

--Cerramos nuestro par�metro.
END;
/

-- 2. NUMERO MAYOR

 --C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Creamos una funci�n que pueda buscar el n�mero mayor que pedimos por par�metro y pero antes declaramos nuestras variables que usaremos m�s adelante.
CREATE OR REPLACE FUNCTION NUMERO_MAYOR (VALOR1 NUMBER, VALOR2 NUMBER, VALOR3 NUMBER)

--Retornamos el mayor.
RETURN NUMBER
AS

MAYOR NUMBER (6);
IGUAL EXCEPTION;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

--Abrimos un bucle if, para crear los par�metros que llevar� nuestra funci�n que en este caso ser� un n�mero mayor que otros.
IF (VALOR1>VALOR2 AND VALOR1>VALOR3) THEN MAYOR := VALOR1;
ELSIF (VALOR2>VALOR1 AND VALOR2>VALOR3) THEN MAYOR := VALOR2;
ELSIF (VALOR3>VALOR1 AND VALOR3>VALOR2) THEN MAYOR := VALOR3;
--Y declaramos el RAISE para crear una excepci�n si elegin dos o tres n�meros iguales.
ELSIF (VALOR1=VALOR2) OR (VALOR2=VALOR3) OR (VALOR1=VALOR3) THEN RAISE IGUAL;
END IF;

--Retornamos el mayor.
RETURN (MAYOR);
--Cerramos el DECLARE con el END.
END;
/

---------------------------------------------------------------
-- 4)	PROCEDIMIENTOS Y FUNCIONES COMPLEJAS ------------------ 
---------------------------------------------------------------

-- 1. DATOS DE EMPLEADO Y SU IRPF

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo pero en este caso con un tama�o en espec�fico.
SET SERVEROUTPUT ON SIZE 1000000;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Creamos un procedimiento que pueda buscar aquellos empleados que elegimos por pantalla y no los imprima en script
-- pero antes declaramos nuestras variables que usaremos m�s adelante.
CREATE OR REPLACE PROCEDURE IRPF_EMPLEADO (NUM_EMPLEADO IN NUMBER)
IS

valor_nombre VARCHAR(15);
valor_apellidos VARCHAR(16);
valor_salario NUMBER(10,2);
valor_tramo NUMBER(2,0);
valor_porcentaje NUMBER(2,2);
NO_DATA_FOUND EXCEPTION;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

--Creamos nuestro SELECT para seleccionar aquel empleado que pidamos por pantalla, e imprimir por pantalla sus datos
    SELECT NOMBRE, APELLIDOS, SALARIO INTO valor_nombre, valor_apellidos, valor_salario
    FROM EMPLEADOS_PAC WHERE id_empleado = num_empleado;
    SELECT tramo_irpf, porcentaje INTO valor_tramo, valor_porcentaje
    FROM IRPF_PAC WHERE valor_salario BETWEEN VALOR_BAJO AND VALOR_ALTO;
--Llamamos por consola todos aquellos par�metros que necesitamos imprimir por pantalla.
    DBMS_OUTPUT.PUT_LINE(valor_nombre||' '||valor_apellidos||' '||'con un sueldo de '||valor_salario||' � en el tramo '||valor_tramo||' y con un IRPF de '||valor_porcentaje*100||'%');
    
--Cerramos nuestro procedimiento.
END;
/

-- 2. NUMERO DE EMPLEADOS POR TRAMO DE IRPF

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Creamos una funci�n que pueda imprimir por pantalla los tramos de los empleados que elegimos por pantalla
-- pero antes declaramos nuestras variables que usaremos m�s adelante.
CREATE OR REPLACE FUNCTION EMPLEADOS_TRAMOS_IRPF (TRAMO_EMPLEADO NUMBER)
--Retornamos el n�mero de empleados.
RETURN NUMBER
IS 

    numero_empleados NUMBER(10, 2);
    N_tramo NUMBER;
    V_bajo NUMBER;
    V_alto NUMBER;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

--Usamos un select para seleccionar el tramo que necesitamos imprimir por pantalla.
    SELECT valor_bajo, valor_alto INTO V_bajo, V_alto FROM irpf_pac WHERE tramo_irpf = TRAMO_EMPLEADO;
    SELECT COUNT (*) INTO numero_empleados FROM EMPLEADOS_PAC WHERE salario BETWEEN V_bajo AND V_alto;
    
--Llamamos por consola todos aquellos par�metros que necesitamos imprimir por pantalla.
    DBMS_OUTPUT.PUT_LINE ('En el tramo '  ||TRAMO_EMPLEADO|| ' de IRPF, tenemos a ' || numero_empleados||' empleados');

--Retornamos el n�mero de empleados.
    RETURN numero_empleados;
    
--Cerramos nuestro par�metro.
END;
/

---------------------------------------------------------------
-- 5)	GESTI�N DE TRIGGERS ----------------------------------- 
---------------------------------------------------------------

-- 1. COMPENSACI�N SALARIO POR CAMBIO TRAMO

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;

--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Creamos un trigger que pueda sumar 1000� al nuevo salario al modificar el salario de un empleado.
-- pero antes declaramos nuestras variables que usaremos m�s adelante.
CREATE OR REPLACE TRIGGER COMPENSA_TRAMO_IRPF
--La actualizaci�n de datos se har� antes de modificar.
    BEFORE UPDATE OF salario ON empleados_pac
--Por cada fila
    FOR EACH ROW 
--Declaramos las variables de que tipo son para luego ejecutarlas pero antes la pedimos por pantalla.
DECLARE
    o_tramo irpf_pac.tramo_irpf%type;
    n_tramo irpf_pac.tramo_irpf%type;
    o_salario empleados_pac.salario%type;
    n_salario empleados_pac.salario%type;
    v_compensacion CONSTANT NUMBER(20):= 1000;
--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

--Usamos un select para seleccionar el salario que necesitamos imprimir por pantalla.
    SELECT tramo_irpf INTO o_tramo FROM irpf_pac WHERE :old.salario BETWEEN valor_bajo AND valor_alto;
    SELECT tramo_irpf INTO n_tramo FROM irpf_pac WHERE :new.salario BETWEEN valor_bajo AND valor_alto;
--Bucle if que nos sumar� 1000� para compensar el cambio de salario. 
    IF n_tramo > o_tramo
        THEN :new.salario := (:new.salario + v_compensacion);
        
--Cerramos nuestro par�metro IF..
    END IF;
    
--Cerramos nuestro par�metro.
END;
/

-- 2. HISTORICO DE CAMBIOS DE SALARIO

/*DROP TABLE audita_salario;
CREATE TABLE audita_salarios (
    id_emp           NUMBER(2),
    salario_antiguo  NUMBER(10, 2),
    salario_nuevo    NUMBER(10, 2),
    fecha            DATE,
    hora             VARCHAR2(10),
    username         VARCHAR2(10)
);*/


CREATE OR REPLACE TRIGGER modificaciones_salarios BEFORE UPDATE OF salario 
    ON ilerna_pac.empleados_pac
    FOR EACH ROW
    FOLLOWS compensa_tramo_irpf
BEGIN
    INSERT INTO ilerna_pac.audita_salarios 
    VALUES (:OLD.id_empleado, :OLD.salario, :NEW.salario,
    SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI:SS'), USER);
END;
/

---------------------------------------------------------------
-- 6)   BLOQUES AN�NIMOS PARA PRUEBAS DE C�DIGO --------------- 
---------------------------------------------------------------

-- 1.	COMPROBACI�N REGISTROS DE TABLAS
/
EXECUTE dbms_output.put_line('-- 1.	COMPROBACI�N REGISTROS DE TABLAS');

--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo pero en este caso con un tama�o en espec�fico.
SET SERVEROUTPUT ON SIZE 1000000;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;
--Declaramos las variables de que tipo son para luego ejecutarlas pero antes la pedimos por pantalla.
DECLARE
----Datos de alumnos
--Creamos un cursor para poder para manejar las sentencias SELECT que nos devolver�n los registros de la tabla alumnos.
    CURSOR tabla_alumnos IS 
    SELECT id_alumno, nombre, apellidos, edad, ciudad
    FROM alumnos_pac
    WHERE id_alumno='ROGOAN';
    
----Datos de asignatura
--Creamos un cursor para poder para manejar las sentencias SELECT que nos devolver�n los registros de la tabla asignatura.
    CURSOR tabla_asignaturas IS 
    SELECT id_asignatura, nombre_asignatura, nombre_profesor, ciclo
    FROM asignaturas_pac
    WHERE id_asignatura='DAX_M02B'; 

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN    
----Datos de alumnos
--Creamos un bucle FOR y conjuntamente con el, pedimos por pantalla que se impriman los registros.
    FOR registro_alumnos IN tabla_alumnos LOOP
    DBMS_OUTPUT.PUT_LINE('El registro de la tabla alumnos_pac es:'||CHR(10)|| 'Id del alumno:'||registro_alumnos.id_alumno||CHR(10)||'Nombre: '||
    registro_alumnos.nombre||CHR(10)||'Apellidos: '||registro_alumnos.apellidos||CHR(10)|| 'Edad: '||registro_alumnos.edad||CHR(10)||
    'Ciudad: '|| registro_alumnos.ciudad);
    END LOOP;
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------------------------------------------');

----Datos de asignatura
--Creamos un bucle FOR y conjuntamente con el, pedimos por pantalla que se impriman los registros.
    FOR registro_asignaturas IN tabla_asignaturas LOOP
    DBMS_OUTPUT.PUT_LINE('El registro de la tabla asignaturas_pac es:'||CHR(10)|| 'Id de la asignatura:'||registro_asignaturas.id_asignatura||CHR(10)||
    'Nombre de la asignatura: '||registro_asignaturas.nombre_asignatura||CHR(10)||'Nombre del profesor: '||registro_asignaturas.nombre_profesor||CHR(10)|| 
    'Ciclo: '||registro_asignaturas.ciclo); 

--Cerramos nuestro par�metro loop.
    END LOOP; 
    
--Cerramos nuestro par�metro.
END;
/

-- 2.	COMPROBACI�N DEL PROCEDIMIENTO �SUMA_IMPARES�
/
EXECUTE dbms_output.put_line('-- 2.	COMPROBACI�N DEL PROCEDIMIENTO �SUMA_IMPARES�');
--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Declaramos las variables de que tipo son para luego ejecutarlas pero antes la pedimos por pantalla.
DECLARE 

elegir_numero NUMBER;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

        elegir_numero:= &Elige;
        SUMA_IMPARES(elegir_numero);
        
--Cerramos nuestro par�metro.
END;
 /

-- 3.	COMPROBACI�N DE LA FUNCION �NUMERO_MAYOR�
/
EXECUTE dbms_output.put_line('-- 3.	COMPROBACI�N DE LA FUNCION �NUMERO_MAYOR�');
--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo, pero en este caso de un tama�o en espec�fico.
SET SERVEROUTPUT ON SIZE 1000000;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Declaramos las variables de que tipo son para luego ejecutarlas.
DECLARE

VALOR1 NUMBER(10,2);
VALOR2 NUMBER(10,2);
VALOR3 NUMBER(10,2);
MAYOR NUMBER(10,2);
IGUAL EXCEPTION;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN
--Pedimos por pantalla los par�metros que tienen por delante la letra & por delante.
	VALOR1 := &Primer_numero;
	VALOR2 := &Segundo_numero;
    VALOR3 := &Tercer_numero;
	MAYOR := NUMERO_MAYOR(VALOR1, VALOR2, VALOR3);

--Llamamos por consola todos aquellos par�metros que necesitamos imprimir por pantalla.
DBMS_OUTPUT.PUT_LINE ('LOS NUMEROS ELEGIDOS SON:' || VALOR1||','|| VALOR2||','|| VALOR3);
DBMS_OUTPUT.PUT_LINE ('EL NUMERO MAYOR DE LA SECUENCIA ES EL  NUMERO_MAYOR: ' ||MAYOR);

--Creamos la exceci�n s�, dos o tres n�meros son iguales con el RAISE y el EXCEPTION.
IF (VALOR1=VALOR2) OR (VALOR2=VALOR3) OR (VALOR1=VALOR3) THEN RAISE igual;
    END IF;

EXCEPTION 
	WHEN IGUAL THEN DBMS_OUTPUT.PUT_LINE ('NO SE PUEDEN REPETIR NUMEROS ');
    
--Cerramos nuestro par�metro.
END;
/

-- 4.	COMPROBACI�N DEL PROCEDIMIENTO �IRPF_EMPLEADO�
/
EXECUTE dbms_output.put_line('-- 4.	COMPROBACI�N DEL PROCEDIMIENTO �IRPF_EMPLEADO�');
--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo pero en este caso con un tama�o en espec�fico.
SET SERVEROUTPUT ON SIZE 1000000;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

DECLARE

num_empleado NUMBER;

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN
        num_empleado:=&numero;
        IRPF_EMPLEADO(num_empleado);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('El n�mero de empleado no existe en la tabla');

--Cerramos nuestro par�metro.
END;
/

-- 5.	COMPROBACI�N DE LA FUNCION �EMPLEADOS_TRAMOS_IRPF�
/
EXECUTE dbms_output.put_line('-- 5.	COMPROBACI�N DE LA FUNCION �EMPLEADOS_TRAMOS_IRPF�');
--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

DECLARE
    N_tramo NUMBER (2,0);
    N_empleados NUMBER (10,2);
    
--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN
N_tramo:=&Elegir;
N_empleados:=EMPLEADOS_TRAMOS_IRPF(N_tramo);

--Cerramos nuestro par�metro.
END;
/

-- 6.	COMPROBACI�N DE LOS TRIGGERS
/
EXECUTE dbms_output.put_line('-- 6.	COMPROBACI�N DE LOS TRIGGERS');
--C�digo principal para poder ejecutar cualquier procedimiento, trigger, funci�n y bloque an�nimo.
SET SERVEROUTPUT ON;
--C�digo para evitar impirmir por pantalla el c�digo entero, sino limitarse a lo que pedimos que imprima por pantalla.
SET VERIFY OFF;

--Declaramos las variables de que tipo son para luego ejecutarlas posteriormente.
DECLARE
v_num_empleado NUMBER(2);
v_salario_empleado NUMBER(10);
v_fecha_mod DATE;
v_hora VARCHAR(10);
v_salario_nuevo_empleado NUMBER(10);
v_salario_antiguo_empleado NUMBER(10);
v_nombre_empleado VARCHAR(20);

--Abrimos begin para luego dentro escribir todos nuestros par�metros.
BEGIN

v_num_empleado:= &num_empleado;
v_salario_empleado:= &salario_empleado;

/*Usamos un update para modificar o actualizar el salario del empleado que pedir� por pantalla el usuario
Y usamos un SELECT para seleccionar espl�citamente lo que necesitamos modificar y imprimirlo en el script.*/
UPDATE ILERNA_PAC.empleados_pac SET salario=v_salario_empleado WHERE id_empleado=v_num_empleado;
SELECT nombre INTO v_nombre_empleado FROM ILERNA_PAC.empleados_pac WHERE v_num_empleado=id_empleado;
SELECT fecha,hora,salario_antiguo,salario_nuevo INTO v_fecha_mod,v_hora,v_salario_antiguo_empleado,v_salario_nuevo_empleado FROM ILERNA_PAC.audita_salarios WHERE v_num_empleado=id_emp;

--Llamamos por consola todos aquellos par�metros que necesitamos imprimir por pantalla.
DBMS_OUTPUT.PUT_LINE('El salario del empleado ' || v_nombre_empleado || ' se ha modificado el d�a ' || v_fecha_mod || ' a las ' || v_hora || ', antes era de ' || v_salario_antiguo_empleado || '� y ahora es de ' || v_salario_nuevo_empleado || '�');

--Cerramos nuestro par�metro.
END;
/

