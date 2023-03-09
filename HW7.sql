// Найти количество завершенных транзакций не в евро на сумму более 100:

db.bank.transactions.count({
  is_completed: true,
  currency: { $ne: "eur" },
  amount: { $gt: 100 }
})

// Для всех пользователей не из Китая и не из Испании увеличить баланс на 
20%:

db.bank.users.updateMany(
  {
    country: { $nin: ["China", "Spain"] }
  },
  {
    $mul: { balance: 1.2 }
  }
)


// Разблокировать пользователей, у которых баланс больше нуля или 
премиальный статус:

db.bank.users.updateMany(
  {
    $or: [
      { balance: { $gt: 0 } },
      { status: "premium" }
    ]
  },
  {
    $set: { is_blocked: false }
  }
)


// Найти пользователей из Китая, которые заблокированы и имеют нулевой 
баланс:

db.bank.users.find({
  country: "China",
  is_blocked: true,
  balance: 0
})


// Пользователям не из Китая и не из США, имеющим баланс более 5000, 
установить статус премиум:

db.bank.users.updateMany(
  {
    country: { $nin: ["China", "USA"] },
    balance: { $gt: 5000 }
  },
  {
    $set: { status: "premium" }
  }
)

