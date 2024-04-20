﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Cust.Master" AutoEventWireup="true" CodeBehind="OrderTrack.aspx.cs" Inherits="Assignment.Customer.OrderTrack" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="OrderTrack.css" />

    <script defer>
        document.addEventListener('DOMContentLoaded', function () {
            // Get the modal element
            var exampleModal = new bootstrap.Modal(document.getElementById('exampleModal'));

            // Add event listener when the modal is about to be shown
            exampleModal.addEventListener('show.bs.modal', function (event) {
                // Button that triggered the modal
                var button = event.relatedTarget;

                // Extract info from data-bs-* attributes
                var recipient = button.getAttribute('data-bs-whatever');

                // Update the modal's content
                var modalTitle = exampleModal._element.querySelector('.modal-title');
                var modalBodyInput = exampleModal._element.querySelector('.modal-body input');

                modalTitle.textContent = 'New message to ' + recipient;
                modalBodyInput.value = recipient;
            });
        });

        function openModal() {
            var exampleModal = new bootstrap.Modal(document.getElementById('exampleModal'));

            // Update the modal's content (optional)
            var modalTitle = exampleModal._element.querySelector('.modal-title');
            var modalBodyInput = exampleModal._element.querySelector('.modal-body input');

            //modalTitle.textContent = 'New message to @getbootstrap';
            //modalBodyInput.value = '@getbootstrap';

            // Show the modal
            exampleModal.show();
        }


        $(function () {

            $(document).on({
                mouseover: function (event) {
                    $(this).find('.far').addClass('star-over');
                    $(this).prevAll().find('.far').addClass('star-over');
                },
                mouseleave: function (event) {
                    $(this).find('.far').removeClass('star-over');
                    $(this).prevAll().find('.far').removeClass('star-over');
                }
            }, '.rate');


            $(document).on('click', '.rate', function () {
                if (!$(this).find('.star').hasClass('rate-active')) {
                    $(this).siblings().find('.star').addClass('far').removeClass('fas rate-active');
                    $(this).find('.star').addClass('rate-active fas').removeClass('far star-over');
                    $(this).prevAll().find('.star').addClass('fas').removeClass('far star-over');
                } else {
                    console.log('has');
                }
            });

        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="track">
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
                <asp:SqlDataSource ID="TrackingSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApexOnlineShopDb %>" SelectCommand="SELECT DISTINCT O.OrderID AS OrderID, O.PaymentAmount AS PaymentAmount, O.OrderDate AS OrderDate, R.OrderQuantity AS OrderQuantity, R.OrderStatus AS OrderStatus, F.FigureID AS FigureID, F.FigureName AS FigureName, F.FigurePrice AS FigurePrice, F.FigureImage1 AS FigureImage1 FROM [Order] O JOIN [Customer] C ON O.CustomerID = C.CustomerID JOIN [OrderFigure] R ON R.OrderID = O.OrderID JOIN [Figure] F ON R.FigureID = F.FigureID WHERE O.CustomerID = @custID ORDER BY OrderDate DESC;">
                    <SelectParameters>
                        <asp:Parameter Name="custID" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:Repeater ID="OrderRepeater" runat="server" OnItemDataBound="OrderRepeater_ItemDataBound">
                    <ItemTemplate>
                        <asp:HiddenField runat="server" ID="hdnDate" Value='<%# Bind("OrderDate", "{0:dd-MM-yyyy}") %>' />
                        <asp:HiddenField runat="server" ID="hdnID" Value='<%# Eval("FigureID") %>' />
                        <!--An Order-->
                        <div class="anOrder">
                            <div class="top-item">
                                <div class="orderID">
                                    <i class='fas fa-tag'></i>&nbsp;Order ID :&nbsp;#<asp:Label runat="server" ID="orderID" Text='<%# Eval("OrderDate", "{0:yyyyMMdd}")+"-"+Eval("OrderID") %>' />
                                </div>
                                <div class="status">
                                    <i class="fa-solid fa-truck"></i>&nbsp;<asp:Label runat="server" ID="lblStatus" Text='<%# Eval("OrderStatus") %>' />
                                </div>
                            </div>
                            <div class="middle1">
                                <div class="img" style="width: 200px; height: contain;">
                                    <asp:ImageButton CssClass="imga" PostBackUrl='<%# "~/Customer/IndividualFigure.aspx?id=" + Eval("FigureID") %>' Style="width: 100%;" runat="server" ID="orderimg" ImageUrl='<%# Eval("FigureImage1") %>' />
                                </div>
                                <div class="product">
                                    <div class="name">
                                        <asp:Label runat="server" ID="lblName" Text='<%# Eval("FigureName") %>' />
                                    </div>
                                    <div class="quantity">
                                        ×<asp:Label runat="server" ID="lblQty" Text='<%# Eval("OrderQuantity") %>' />
                                    </div>
                                </div>
                                <div class="subtotal">
                                    <asp:Button ID="btnToOpenFeedback" runat="server" Text="Rate" CommandArgument='<%# Eval("FigureID") %>' OnCommand="btnToOpenFeedback_Command" />
                                </div>
                            </div>
                            <div class="middle2">
                                <div class="noOfItems">
                                    <asp:Label Style="color: grey" runat="server" ID="lblOrderDate" Text='<%# Bind("OrderDate", "{0:dd-MM-yyyy}") %>' />
                                </div>
                                <div class="totalForAll" style="font-size: 18px;">
                                    <span style="color: grey">Order Total :</span>&nbsp;<asp:Label Style="font-weight: bold; color: #ff7e29" runat="server" ID="lblTotal" Text='<%# "RM "+Eval("PaymentAmount") %>' />
                                </div>
                            </div>
                            <div class="bottom">
                                <div class="estimate">
                                    Products will be shipped out by&nbsp;<asp:Label Style="text-decoration: underline" runat="server" ID="lblEstimateDate" Text="" />
                                </div>
                                <div class="view-order-btn">
                                    <asp:LinkButton CommandArgument='<%# Eval("OrderID") %>' CssClass="viewOrder btn border" runat="server" ID="viewOrder" OnCommand="viewOrder_Command">
                                        <i class="fa-solid fa-circle-info"></i>&nbsp;&nbsp;VIEW ORDER
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <!--End Of An Order-->
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblFail" runat="server" Text="" Style="font-weight: bold; color: red; font-size: 20px; margin-top: 100px; margin-bottom: 100px;"></asp:Label>

                <!--Rating Model-->
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel" style="font-size: 25px;"><b>Product Feedback</b></h5>
                                <asp:Button ID="btnClose" runat="server" class="btn-close" data-bs-dismiss="modal" aria-label="Close" />
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">

                                    <asp:Label ID="lblRate" runat="server" CssClass="col-form-label" Text="Product Rating: " Style="margin-top: 100px;"></asp:Label>


                                    <div class="wrap" style="margin-bottom: 20px;">

                                        <asp:RadioButtonList RepeatDirection="Horizontal" ID="r" runat="server">
                                            <asp:ListItem Value="1" Style="margin-right: 10px; display: flex; flex-flow: column nowrap; color: crimson">&#9733;1</asp:ListItem>
                                            <asp:ListItem Value="2" Style="margin-right: 10px; display: flex; flex-flow: column nowrap; color: crimson">&#9733;2</asp:ListItem>
                                            <asp:ListItem Value="3" Style="margin-right: 10px; display: flex; flex-flow: column nowrap; color: crimson">&#9733;3</asp:ListItem>
                                            <asp:ListItem Value="4" Style="margin-right: 10px; display: flex; flex-flow: column nowrap; color: crimson">&#9733;4</asp:ListItem>
                                            <asp:ListItem Value="5" Style="margin-right: 10px; display: flex; flex-flow: column nowrap; color: crimson">&#9733;5</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <br />
                                    <asp:Label ID="lblFeedback" runat="server" Text="Feedback: " CssClass="col-form-label"></asp:Label>
                                    <asp:TextBox ID="txtFeedback" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-danger" Text="Submit" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End of rating modal -->
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



    <script>
        //May need to change. When the user click on a button, the system should trigger the click button whether is "Order Received", "Shipping", "All Order" or something else. Apply the "select" class according to the value. 

        function allOrder() {
            document.getElementById("all").classList.add("select");
            document.getElementById("pending").classList.remove("select");
            document.getElementById("shipping").classList.remove("select");
            document.getElementById("delivered").classList.remove("select");
        }

        function pending() {
            document.getElementById("pending").classList.add("select");
            document.getElementById("all").classList.remove("select");
            document.getElementById("shipping").classList.remove("select");
            document.getElementById("delivered").classList.remove("select");
        }

        function shipping() {
            document.getElementById("shipping").classList.add("select");
            document.getElementById("pending").classList.remove("select");
            document.getElementById("all").classList.remove("select");
            document.getElementById("delivered").classList.remove("select");
        }

        function delivered() {
            document.getElementById("delivered").classList.add("select");
            document.getElementById("pending").classList.remove("select");
            document.getElementById("shipping").classList.remove("select");
            document.getElementById("all").classList.remove("select");
        }
    </script>
</asp:Content>
