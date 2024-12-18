﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Cust.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="Assignment.Customer.OrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="OrderDetail.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="detail">
        <div class="sidebar" id="sidebar">
            <div class="tt">
                <div id="ttt" class="ttt">
                    <span class="sel">MY ACTION</span>
                </div>

                <i style="font-size: 20px;" class="btn-show fa-solid fa-angles-left"></i>

            </div>
            <div class="inner-side">
                <asp:LinkButton CausesValidation="false" PostBackUrl="~/Customer/UserProfile.aspx" CssClass="lb" runat="server" ID="goProfile">
           <i class="fa-solid fa-address-card"></i>&nbsp;&nbsp;<span class="sel">MY PROFILE</span>
                </asp:LinkButton>

                <asp:LinkButton CausesValidation="false" PostBackUrl="~/Customer/EditProfile.aspx" CssClass="lb" runat="server" ID="goEdit">
           <i class="fa-solid fa-pen-to-square"></i>&nbsp;&nbsp;<span class="sel">EDIT PROFILE</span>
                </asp:LinkButton>

                <asp:LinkButton Style="color: #ff7e29" CausesValidation="false" PostBackUrl="~/Customer/OrderTrack.aspx" CssClass="lb" runat="server" ID="goOrder">
           <i class="fa-solid fa-cart-shopping"></i>&nbsp;&nbsp;<span class="sel">MY ORDER</span>
                </asp:LinkButton>

                <asp:LinkButton CausesValidation="false" OnClick="goLogout_Click" CssClass="lb" runat="server" ID="goLogout">
           <i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;<span class="sel">LOGOUT</span>
                </asp:LinkButton>
            </div>
        </div>

        <div class="main-content">
            <div class="order-container">
                <div class="back">
                    <asp:LinkButton PostBackUrl="~/Customer/OrderTrack.aspx" CssClass="lbn" runat="server">
                        <i class="fa-solid fa-arrow-left"></i>&nbsp;&nbsp;&nbsp;Orders
                    </asp:LinkButton>
                </div>
                <div class="order-title">
                    <div class="top-title">
                        <div class="title">
                            Order details&nbsp;#<asp:Label runat="server" ID="lblOrderID" Text='<%# Eval("OrderDate", "{0:yyyyMMdd}")+"-"+Eval("OrderID") %>' />
                        </div>
                        <div class="current-status">
                            <asp:Label runat="server" ID="lblStatus" Text='<%# Eval("OrderStatus") %>' />
                        </div>
                    </div>
                    <div class="date-title">
                        <div class="date">
                            Order Date:&nbsp;<asp:Label runat="server" ID="lblOrderDate" Text='<%# Bind("OrderDate", "{0:dd-MM-yyyy}") %>' />
                        </div>
                        |
                        <div class="estimate">
                            Estimate Arrival Date:&nbsp;<asp:Label runat="server" ID="lblEstimateDate" Text="" />
                        </div>
                    </div>
                </div>
                <div class="status-container">
                    <div class="status-line">
                        <div id="bar-progress" class="mt-5 mt-lg-0">
                            <!--Add step-active class for current phase-->
                            <div class="step">
                                <span class="check-container">
                                    <span class="check"><i class="fa-regular fa-clipboard"></i></span>
                                </span>
                                <h5>ORDER RECEIVED</h5>
                                <div class="done-date">
                                    <asp:Label runat="server" ID="lblOrderDate2" Text="" />
                                </div>
                            </div>
                            <div class="seperator"></div>
                            <div class="step">
                                <span class="check-container">
                                    <span class="check"><i class="fa-solid fa-truck"></i></span>
                                </span>
                                <h5>PENDING</h5>
                                <div class="done-date">
                                    <asp:Label runat="server" ID="lblPendingDate" Text="" />
                                </div>
                            </div>
                            <div class="seperator"></div>
                            <div class="step">
                                <span class="check-container">
                                    <span class="check"><i class="fa-solid fa-truck-fast"></i></span>
                                </span>
                                <h5>SHIPPING</h5>
                                <div class="done-date">
                                    <asp:Label runat="server" ID="lblShippingDate" Text="" />
                                </div>
                            </div>
                            <div class="seperator"></div>
                            <div class="step">
                                <span class="check-container">
                                    <span class="check"><i class="fa-solid fa-check"></i></span>
                                </span>
                                <h5>DELIVERED</h5>
                                <div class="done-date">
                                    <asp:Label runat="server" ID="lblDeliveredDate" Text="" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-ordered">
                        <div class="item-ordered-title">
                            Item Ordered
                        </div>

                        <div class="items-cont">
                            <asp:Repeater ID="ItemRepeater" runat="server">
                                <ItemTemplate>
                                    <!--An Item-->
                                    <div class="products">
                                        <div class="left">
                                            <div class="img">
                                                <asp:Image Style="width: 100%;" runat="server" ID="orderImg" ImageUrl='<%# Eval("FigureImage1") %>' />
                                            </div>
                                            <div class="text">
                                                <div class="product-name" style="color: #ff7e29; font-weight: bold; font-size: 18px;">
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("FigureName") %>' />
                                                </div>
                                                <div class="qty">
                                                    <span>Quantity :&nbsp;</span><asp:Label ID="lblQty" runat="server" Text='<%# Eval("OrderQuantity") %>' />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="right">
                                            <asp:Label runat="server" ID="itemtotal" Text="" />
                                        </div>
                                    </div>
                                    <!--End of An Item-->
                                </ItemTemplate>
                            </asp:Repeater>


                            <!--Bottom Information-->
                            <div class="bottom-info">
                                <div class="b1">
                                    <div class="t" style="color: #ff7e29">Information</div>
                                    <table class="info-container">
                                        <tr>
                                            <th>Name</th>
                                            <td>:</td>
                                            <td>
                                                <asp:Label runat="server" ID="purchaseName" Text="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Phone No.</th>
                                            <td>:</td>
                                            <td>
                                                <asp:Label runat="server" ID="phoneNo" Text="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Home Address
                                            </th>
                                            <td>:</td>
                                            <td>
                                                <asp:Label runat="server" ID="homeAddress" Text="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Payment Method
                                            </th>
                                            <td>:</td>
                                            <td>
                                                <asp:Label runat="server" ID="paymentMethod" Text="" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="b2">
                                    <div class="t" style="color: #ff7e29">Order Summary</div>
                                    <table class="order-summary">
                                        <tr>
                                            <th>Subtotal
                                            </th>
                                            <td>:</td>
                                            <td class="tRight">
                                                <asp:Label runat="server" ID="lblSubtotal" Text="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Delivery
                                            </th>
                                            <td>:</td>
                                            <td class="tRight">
                                                <asp:Label runat="server" ID="lblDelivery" Text="RM 25.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="padding-bottom: 20px;">Tax
                                            </th>
                                            <td style="padding-bottom: 20px;">:</td>
                                            <td class="tRight" style="padding-bottom: 20px;">
                                                <asp:Label runat="server" ID="lblTax" Type="" Text="" />
                                            </td>
                                        </tr>
                                        <tr class="last-column">
                                            <th style="padding-top: 20px;">Total
                                            </th>
                                            <td style="font-weight: 100; padding-top: 20px;">:</td>
                                            <td style="padding-top: 20px;" class="tRight">
                                                <asp:Label runat="server" ID="lblTotal" Text="" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="JS" runat="server">
    <script type="text/javascript">
        let show = document.querySelector(".btn-show");
        let title = document.querySelectorAll(".sel");
        let sidebar = document.getElementById("sidebar");
        let ttt = document.getElementById("ttt");
        var option = sessionStorage.getItem("option");

        show.addEventListener("click", () => {
            if (option === "show" || option === null) {
                sessionStorage.setItem("option", "hide");
                location.reload();
            } else if (option === "hide") {
                sessionStorage.setItem("option", "show");
                location.reload();
            }
        })

    </script>
    <script>
        function run() {

            if (option === "hide") {

                //operation
                show.classList.replace("fa-angles-left", "fa-angles-right");
                sidebar.style.width = "auto";
                ttt.style.display = "none";

                title.forEach(tt => {
                    tt.classList.add("hideTitle");
                })

                $('#<%= goProfile.ClientID %>').hover(function () {
                    $(this).tooltip({ placement: "right", title: "MY PROFILE" });
                });
                $('#<%= goEdit.ClientID %>').hover(function () {
                    $(this).tooltip({ placement: "right", title: "EDIT PROFILE" });
                });
                $('#<%= goOrder.ClientID %>').hover(function () {
                    $(this).tooltip({ placement: "right", title: "MY ORDER" });
                });
                $('#<%= goLogout.ClientID %>').hover(function () {
                    $(this).tooltip({ placement: "right", title: "LOGOUT" });
                });
            } else if (option === "show") {

                //operation
                show.classList.replace("fa-angles-right", "fa-angles-left");
                sidebar.style.width = "200px";
                ttt.style.display = "block";

                title.forEach(tt => {
                    tt.classList.remove("hideTitle");
                })

                $('#<%= goProfile.ClientID %>').hover(function () {
                    $(this).tooltip("dispose");
                });
                $('#<%= goEdit.ClientID %>').hover(function () {
                    $(this).tooltip("dispose");
                });
                $('#<%= goOrder.ClientID %>').hover(function () {
                    $(this).tooltip("dispose");
                });
                $('#<%= goLogout.ClientID %>').hover(function () {
                    $(this).tooltip("dispose");
                });
            }

        }

    </script>


    <script type="text/javascript">

        function orderStatus() {
            var orderStatus = '<%= Session["orderStatus"] %>';

            var statusDivs = document.querySelectorAll('.status-line .step');

            statusDivs.forEach(function (div) {
                var title = div.querySelector('h5').innerText;
                if (orderStatus === "Delivered") {
                    div.classList.add('step-active');
                } else {
                    div.classList.remove('step-active');
                }
            });

            if (orderStatus === "Pending" || orderStatus === "Shipping") {
                var stepActiveCount = orderStatus === "Pending" ? 2 : 3;
                for (var i = 0; i < stepActiveCount; i++) {
                    statusDivs[i].classList.add('step-active');
                }
            }
        }
    </script>

</asp:Content>
