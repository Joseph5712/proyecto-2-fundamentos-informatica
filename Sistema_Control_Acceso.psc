Algoritmo Sistema_Control_Acceso
	
	Definir Usuarios Como Coleccion de registro de (cedula, nombre)
	Definir Registros Como Coleccion de registro de (cedula, entrada, salida)
	Definir Aulas Como Coleccion de cadena
	Definir Equipos Como Coleccion de cadena
	Definir Laboratorios Como Coleccion de cadena
	
	Repetir
		Escribir "Sistema de Control de Accesoo"
		Escribir "1. Registrar Usuario"
		Escribir "2. Registrar Entrada/Salida"
		Escribir "3. Gestionar Aulas"
		Escribir "4. Solicitar Equipo/Laboratorio"
		Escribir "5. Salir"
		Leer opcion
		
		Segun opcion Hacer
			1:
				Registrar_Usuario(Usuarios)
			2:
				Registrar_Entrada_Salida(Registros, Usuarios)
			3:
				Gestionar_Aulas(Aulas)
			4:
				Solicitar_Equipo_Laboratorio(Equipos, Laboratorios)
			5:
				Escribir "Gracias por usar el sistema"
			De Otro Modo:
				Escribir "Opción inválida, intente de nuevo"
		Fin Segun
		
	Hasta Que opcion == 5
	
Fin Algoritmo

SubAlgoritmo Registrar_Usuario(Usuarios)
	Escribir "Ingrese cédula:"
	Leer cedula
	Escribir "Ingrese nombre:"
	Leer nombre
	Si No Existe_Usuario(Usuarios, cedula) Entonces
		Agregar(Usuarios, cedula, nombre)
		Escribir "Usuario registrado exitosamente."
	Sino
		Escribir "El usuario ya está registrado."
	Fin Si
Fin SubAlgoritmo

SubAlgoritmo Registrar_Entrada_Salida(Registros, Usuarios)
	// Implementar la lógica para entrada y salida aquí
Fin SubAlgoritmo

SubAlgoritmo Gestionar_Aulas(Aulas)
	// Implementar la gestión de aulas aquí
Fin SubAlgoritmo

SubAlgoritmo Solicitar_Equipo_Laboratorio(Equipos, Laboratorios)
	// Implementar la solicitud de equipos y laboratorios aquí
Fin SubAlgoritmo

