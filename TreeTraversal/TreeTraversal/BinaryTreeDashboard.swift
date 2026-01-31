//
//  ContentView.swift
//  TreeTraversal
//
//  Created by Kundan Kumar on 31/01/26.
//

import SwiftUI

struct BinaryTreeDashboard: View {
    @State private var traversalResult: [String] = []
    
    // Sample Tree: Root(A) -> Left(B), Right(C)
    let root = TreeNode("A",
                 left: TreeNode("B", left: TreeNode("D"), right: TreeNode("E")),
                 right: TreeNode("C", left: TreeNode("F")))

    var body: some View {
        VStack(spacing: 30) {
            Text("Binary Tree Traversal")
                .font(.largeTitle).bold()

            // Tree Visualization
            ScrollView([.horizontal, .vertical]) {
                NodeView(node: root)
                    .padding()
            }
            .frame(height: 300)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

            // Traversal Result Display
            VStack {
                Text("Result Order:")
                    .font(.caption).foregroundColor(.secondary)
                Text(traversalResult.joined(separator: " → "))
                    .font(.title3).bold()
                    .animation(.easeInOut, value: traversalResult)
            }

            // Action Buttons
            HStack {
                Button("Inorder") { traversalResult = root.traverseInOrder() }
                Button("Preorder") { traversalResult = root.traversePreOrder() }
                Button("Postorder") { traversalResult = root.traversePostOrder() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

class TreeNode: Identifiable {
    let id = UUID()
    var value: String
    var left: TreeNode?
    var right: TreeNode?

    init(_ value: String, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }

    func traverseInOrder() -> [String] {
        return (left?.traverseInOrder() ?? []) + [value] + (right?.traverseInOrder() ?? [])
    }

    func traversePreOrder() -> [String] {
        return [value] + (left?.traversePreOrder() ?? []) + (right?.traversePreOrder() ?? [])
    }

    func traversePostOrder() -> [String] {
        return (left?.traversePostOrder() ?? []) + (right?.traversePostOrder() ?? []) + [value]
    }
}

struct NodeView: View {
    let node: TreeNode

    var body: some View {
        VStack(spacing: 20) {
            Text(node.value)
                .font(.headline)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.blue.opacity(0.2)))
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))

            HStack(alignment: .top, spacing: 20) {
                if let left = node.left {
                    NodeView(node: left)
                }
                if let right = node.right {
                    NodeView(node: right)
                }
            }
        }
    }
}

// Preview provider for the SwiftUI canvas
#Preview {
    BinaryTreeDashboard()
}

