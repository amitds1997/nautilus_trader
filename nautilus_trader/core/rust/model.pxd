# Warning, this file is autogenerated by cbindgen. Don't modify this manually. */

from cpython.object cimport PyObject
from libc.stdint cimport uint8_t, uint16_t, uint64_t, int64_t

cdef extern from "../includes/model.h":

    const uint8_t FIXED_PRECISION # = 9

    const double FIXED_SCALAR # = 1000000000.0

    cdef enum BookLevel:
        L1_TBBO # = 1,
        L2_MBP # = 2,
        L3_MBO # = 3,

    cdef enum CurrencyType:
        Crypto,
        Fiat,

    cdef enum OrderSide:
        Buy # = 1,
        Sell # = 2,

    cdef struct BTreeMap_BookPrice__Level:
        pass

    cdef struct HashMap_u64__BookPrice:
        pass

    cdef struct String:
        pass

    cdef struct Symbol_t:
        String *value;

    cdef struct Venue_t:
        String *value;

    cdef struct InstrumentId_t:
        Symbol_t symbol;
        Venue_t venue;

    cdef struct Price_t:
        int64_t raw;
        uint8_t precision;

    cdef struct Quantity_t:
        uint64_t raw;
        uint8_t precision;

    # Represents a single quote tick in a financial market.
    cdef struct QuoteTick_t:
        InstrumentId_t instrument_id;
        Price_t bid;
        Price_t ask;
        Quantity_t bid_size;
        Quantity_t ask_size;
        int64_t ts_event;
        int64_t ts_init;

    cdef struct TradeId_t:
        String *value;

    # Represents a single trade tick in a financial market.
    cdef struct TradeTick_t:
        InstrumentId_t instrument_id;
        Price_t price;
        Quantity_t size;
        OrderSide aggressor_side;
        TradeId_t trade_id;
        int64_t ts_event;
        int64_t ts_init;

    cdef struct AccountId_t:
        String *value;

    cdef struct ClientId_t:
        String *value;

    cdef struct ClientOrderId_t:
        String *value;

    cdef struct ComponentId_t:
        String *value;

    cdef struct OrderListId_t:
        String *value;

    cdef struct PositionId_t:
        String *value;

    cdef struct StrategyId_t:
        String *value;

    cdef struct TraderId_t:
        String *value;

    cdef struct VenueOrderId_t:
        String *value;

    cdef struct Ladder:
        OrderSide side;
        BTreeMap_BookPrice__Level *levels;
        HashMap_u64__BookPrice *cache;

    cdef struct OrderBook:
        Ladder bids;
        Ladder asks;
        InstrumentId_t instrument_id;
        BookLevel book_level;
        OrderSide last_side;
        int64_t ts_last;

    cdef struct Currency_t:
        String *code;
        uint8_t precision;
        uint16_t iso4217;
        String *name;
        CurrencyType currency_type;

    cdef struct Money_t:
        int64_t raw;
        Currency_t currency;

    void quote_tick_free(QuoteTick_t tick);

    QuoteTick_t quote_tick_new(InstrumentId_t instrument_id,
                               Price_t bid,
                               Price_t ask,
                               Quantity_t bid_size,
                               Quantity_t ask_size,
                               int64_t ts_event,
                               int64_t ts_init);

    QuoteTick_t quote_tick_from_raw(InstrumentId_t instrument_id,
                                    int64_t bid,
                                    int64_t ask,
                                    uint8_t price_prec,
                                    uint64_t bid_size,
                                    uint64_t ask_size,
                                    uint8_t size_prec,
                                    int64_t ts_event,
                                    int64_t ts_init);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *quote_tick_to_pystr(const QuoteTick_t *tick);

    void trade_tick_free(TradeTick_t tick);

    TradeTick_t trade_tick_from_raw(InstrumentId_t instrument_id,
                                    int64_t price,
                                    uint8_t price_prec,
                                    uint64_t size,
                                    uint8_t size_prec,
                                    OrderSide aggressor_side,
                                    TradeId_t trade_id,
                                    int64_t ts_event,
                                    int64_t ts_init);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *trade_tick_to_pystr(const TradeTick_t *tick);

    void account_id_free(AccountId_t account_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    AccountId_t account_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *account_id_to_pystr(const AccountId_t *account_id);

    uint8_t account_id_eq(const AccountId_t *lhs, const AccountId_t *rhs);

    uint64_t account_id_hash(const AccountId_t *account_id);

    void client_id_free(ClientId_t client_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    ClientId_t client_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *client_id_to_pystr(const ClientId_t *client_id);

    uint8_t client_id_eq(const ClientId_t *lhs, const ClientId_t *rhs);

    uint64_t client_id_hash(const ClientId_t *client_id);

    void client_order_id_free(ClientOrderId_t client_order_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    ClientOrderId_t client_order_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *client_order_id_to_pystr(const ClientOrderId_t *client_order_id);

    uint8_t client_order_id_eq(const ClientOrderId_t *lhs, const ClientOrderId_t *rhs);

    uint64_t client_order_id_hash(const ClientOrderId_t *client_order_id);

    void component_id_free(ComponentId_t component_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    ComponentId_t component_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *component_to_pystr(const ComponentId_t *component_id);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *component_id_to_pystr(const ComponentId_t *component_id);

    uint8_t component_id_eq(const ComponentId_t *lhs, const ComponentId_t *rhs);

    uint64_t component_id_hash(const ComponentId_t *component_id);

    void instrument_id_free(InstrumentId_t instrument_id);

    # Returns a Nautilus identifier from valid Python object pointers.
    #
    # # Safety
    # - `symbol_ptr` and `venue_ptr` must be borrowed from a valid Python UTF-8 `str`(s).
    InstrumentId_t instrument_id_from_pystrs(PyObject *symbol_ptr, PyObject *venue_ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *instrument_id_to_pystr(const InstrumentId_t *instrument_id);

    uint8_t instrument_id_eq(const InstrumentId_t *lhs, const InstrumentId_t *rhs);

    uint64_t instrument_id_hash(const InstrumentId_t *instrument_id);

    void order_list_id_free(OrderListId_t order_list_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    OrderListId_t order_list_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *order_list_id_to_pystr(const OrderListId_t *order_list_id);

    uint8_t order_list_id_eq(const OrderListId_t *lhs, const OrderListId_t *rhs);

    uint64_t order_list_id_hash(const OrderListId_t *order_list_id);

    void position_id_free(PositionId_t position_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    PositionId_t position_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *position_id_to_pystr(const PositionId_t *position_id);

    uint8_t position_id_eq(const PositionId_t *lhs, const PositionId_t *rhs);

    uint64_t position_id_hash(const PositionId_t *position_id);

    void strategy_id_free(StrategyId_t strategy_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    StrategyId_t strategy_id_from_pystr(PyObject *ptr);

    void symbol_free(Symbol_t symbol);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    Symbol_t symbol_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *symbol_to_pystr(const Symbol_t *symbol);

    uint8_t symbol_eq(const Symbol_t *lhs, const Symbol_t *rhs);

    uint64_t symbol_hash(const Symbol_t *symbol);

    void trade_id_free(TradeId_t trade_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    TradeId_t trade_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *trade_id_to_pystr(const TradeId_t *trade_id);

    uint8_t trade_id_eq(const TradeId_t *lhs, const TradeId_t *rhs);

    uint64_t trade_id_hash(const TradeId_t *trade_id);

    void trader_id_free(TraderId_t trader_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    TraderId_t trader_id_from_pystr(PyObject *ptr);

    void venue_free(Venue_t venue);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    Venue_t venue_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *venue_to_pystr(const Venue_t *venue);

    uint8_t venue_eq(const Venue_t *lhs, const Venue_t *rhs);

    uint64_t venue_hash(const Venue_t *venue);

    void venue_order_id_free(VenueOrderId_t venue_order_id);

    # Returns a Nautilus identifier from a valid Python object pointer.
    #
    # # Safety
    # - `ptr` must be borrowed from a valid Python UTF-8 `str`.
    VenueOrderId_t venue_order_id_from_pystr(PyObject *ptr);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *venue_order_id_to_pystr(const VenueOrderId_t *venue_order_id);

    uint8_t venue_order_id_eq(const VenueOrderId_t *lhs, const VenueOrderId_t *rhs);

    uint64_t venue_order_id_hash(const VenueOrderId_t *venue_order_id);

    OrderBook order_book_new(InstrumentId_t instrument_id, BookLevel book_level);

    # Returns a `Currency` from valid Python object pointers and primitives.
    #
    # # Safety
    # - `code_ptr` and `name_ptr` must be borrowed from a valid Python UTF-8 `str`(s).
    Currency_t currency_from_py(PyObject *code_ptr,
                                uint8_t precision,
                                uint16_t iso4217,
                                PyObject *name_ptr,
                                CurrencyType currency_type);

    void currency_free(Currency_t currency);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *currency_to_pystr(const Currency_t *currency);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *currency_code_to_pystr(const Currency_t *currency);

    # Returns a pointer to a valid Python UTF-8 string.
    #
    # # Safety
    # - Assumes that since the data is originating from Rust, the GIL does not need
    # to be acquired.
    # - Assumes you are immediately returning this pointer to Python.
    PyObject *currency_name_to_pystr(const Currency_t *currency);

    uint8_t currency_eq(const Currency_t *lhs, const Currency_t *rhs);

    uint64_t currency_hash(const Currency_t *currency);

    Money_t money_new(double amount, Currency_t currency);

    Money_t money_from_raw(int64_t raw, Currency_t currency);

    void money_free(Money_t money);

    double money_as_f64(const Money_t *money);

    void money_add_assign(Money_t a, Money_t b);

    void money_sub_assign(Money_t a, Money_t b);

    Price_t price_new(double value, uint8_t precision);

    Price_t price_from_raw(int64_t raw, uint8_t precision);

    void price_free(Price_t price);

    double price_as_f64(const Price_t *price);

    void price_add_assign(Price_t a, Price_t b);

    void price_sub_assign(Price_t a, Price_t b);

    Quantity_t quantity_new(double value, uint8_t precision);

    Quantity_t quantity_from_raw(uint64_t raw, uint8_t precision);

    void quantity_free(Quantity_t qty);

    double quantity_as_f64(const Quantity_t *qty);

    void quantity_add_assign(Quantity_t a, Quantity_t b);

    void quantity_add_assign_u64(Quantity_t a, uint64_t b);

    void quantity_sub_assign(Quantity_t a, Quantity_t b);

    void quantity_sub_assign_u64(Quantity_t a, uint64_t b);
