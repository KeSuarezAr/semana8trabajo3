# BLoC en Flutter

BLoC (Business Logic Component) es un patrón de diseño presentado por Paolo Soares y Cong Hui de Google en DartConf 2018. BLoC se basa en la idea de que la entrada y salida de cada componente (en este caso, los componentes de la lógica de negocio) deben ser flujos y sumideros de eventos.

### Eventos

Los eventos son la entrada a un BLoC. Son enviados por la interfaz de usuario y describen acciones del usuario o cambios de estado del sistema.

```dart
enum TaskEvent { add, delete }
```

### Estados

Los estados son la salida de un BLoC y representan una parte del estado de la aplicación. Los estados son consumidos por la interfaz de usuario para actualizar la presentación de la aplicación.

```dart
class TaskBloc extends Bloc<TaskEvent, List<String>> { ... }
```

### Transiciones

Las transiciones son cambios de un estado a otro en respuesta a un evento. Se definen en el BLoC.

```dart
on<TaskEvent>((event, emit) {
  if (event == TaskEvent.add) {
    emit([...state, 'Tarea ${state.length + 1}']);
  } else if (event == TaskEvent.delete) {
    if (state.isNotEmpty) {
      emit(state.take(state.length - 1).toList());
    }
  }
});
```

## Ventajas de BLoC

- Separación de la lógica de negocio de la interfaz de usuario, lo que facilita las pruebas y la reutilización del código.
- Uso de flujos para manejar eventos y estados, lo que permite una programación reactiva y asincrónica.

```
Este README proporciona una breve introducción a los conceptos clave de BLoC en Flutter, incluyendo eventos, estados y transiciones, y menciona algunas de las ventajas de usar BLoC.
```
