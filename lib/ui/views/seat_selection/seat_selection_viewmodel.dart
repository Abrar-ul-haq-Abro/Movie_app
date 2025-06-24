import 'package:stacked/stacked.dart';

enum SeatType { available, unavailable, selected, vip }

class Seat {
  final int row;
  final int col;
  SeatType type;

  Seat({required this.row, required this.col, this.type = SeatType.available});
}

class SeatSelectionViewModel extends BaseViewModel {
  List<List<Seat>> _seatLayout = [];
  List<List<Seat>> get seatLayout => _seatLayout;

  final List<Seat> _selectedSeats = [];
  List<Seat> get selectedSeats => _selectedSeats;

  final double _vipPrice = 150.0;
  final double _regularPrice = 50.0;
  
  double get totalPrice => _selectedSeats.fold(0, (total, seat) {
    return total + (seat.type == SeatType.vip ? _vipPrice : _regularPrice);
  });

  void onModelReady() {
    _generateSeatLayout();
    notifyListeners();
  }

  void _generateSeatLayout() {
    _seatLayout = List.generate(10, (row) {
      return List.generate(16, (col) {
        if (col == 4 || col == 11) {
          return Seat(row: row, col: col, type: SeatType.unavailable); // Aisle
        }
        if (row > 8) {
          return Seat(row: row, col: col, type: SeatType.vip);
        }
        return Seat(row: row, col: col, type: SeatType.available);
      });
    });
  }

  void selectSeat(Seat seat) {
    if (seat.type == SeatType.available || seat.type == SeatType.vip) {
      seat.type = SeatType.selected;
      _selectedSeats.add(seat);
    } else if (seat.type == SeatType.selected) {
      seat.type = seat.row > 8 ? SeatType.vip : SeatType.available;
      _selectedSeats.remove(seat);
    }
    notifyListeners();
  }
} 