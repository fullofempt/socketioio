enum SocketEvent {
  unknow, //для того чтобы строки были каких-то определнных значений. Сервер принимает только эти значения
  login,
  logout,
  newMessage,
}