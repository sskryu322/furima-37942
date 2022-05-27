const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  // 下のbuttonはビューの送信ボタンのid
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    // 下の記述でRuby on Railsにおけるフォーム送信処理はキャンセルしている
    e.preventDefault();
    
    // ここからが追記 フォームの情報を取得している
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      // フォームの入力情報をcardに代入している
      // 下のorder[number]は各フォームのname属性を記述している
      number: formData.get("purchase_address[number]"),
      exp_month: formData.get("purchase_address[exp_month]"),
      exp_year: `20${formData.get("purchase_address[exp_year]")}`,
      cvc: formData.get("purchase_address[cvc]"),
    };
    // カードの情報をトークン化
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // 下の記述でフォームの中に作成したinput要素を追加しています。
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // フォームに存在するクレジットカードの各情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      // JavaScript側からフォームの送信処理を行う
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);